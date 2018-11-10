import re
from DataStructure import *
from collections import OrderedDict
from DetectBug import *
from StatementExecutor import *
from MainProcess import generator_for_dimension_var


_INITIAL_MARK = 'initial'


def parse_all_variable_from_string(target_string):
    result_lst = list()
    for single_var in re.finditer(r"%\w+", target_string):
        real_var = target_string[single_var.start(): single_var.end()]
        if real_var.find("%struct") == -1:
            result_lst.append(real_var)
    for single_var in re.finditer(r"@\w+", target_string):
        real_var = target_string[single_var.start(): single_var.end()]
        if real_var.find("thread") == -1 and real_var.find("block") == -1:
            result_lst.append(real_var)
    return result_lst


def get_updated_and_depended_vars(target_line):
    updated_var = None
    depended_vars = list()
    if len(re.findall(r"(@|%)\w+\s*=\s*(.*)", target_line, re.DOTALL)) != 0:
        tmp_arr = target_line.split("=")
        updated_var = parse_all_variable_from_string(tmp_arr[0])[0]
        depended_vars = parse_all_variable_from_string(tmp_arr[1])
    elif target_line.find("store") != -1:
        all_vars = parse_all_variable_from_string(target_line)
        if len(all_vars) < 2:
            all_vars.append(all_vars[0])  # immediate value
        updated_var = all_vars[1]
        depended_vars = [all_vars[0]]
    return updated_var, depended_vars


def list_item_in_dict(target_lst, target_dict):
    for item in target_lst:
        if item in target_dict:
            return True
    return False


def trace_target_memory(global_env, function_name, target_memory):
    target_function = global_env.get_value(function_name)
    variable_set = dict()
    variable_set[target_memory] = True
    result_lst = list()
    target_kernel_codes = KernelCodes(target_function.raw_codes).codes
    for line_index in xrange(len(target_kernel_codes)):
        each_line = target_kernel_codes[line_index]
        updated_var, depended_vars = get_updated_and_depended_vars(each_line)
        if list_item_in_dict(depended_vars, variable_set) or updated_var in variable_set:
            if each_line.find('load') != -1 or each_line.find('store') != -1:
                if each_line.find('**') != -1:
                    variable_set[updated_var] = True  # load address to other variable
                else:
                    if each_line.find('store') != -1:
                        result_lst.append((each_line, line_index))  # only record store
            elif each_line.find('getelementptr') != -1:
                variable_set[updated_var] = True
    return result_lst


def generate_variable_depend_path(global_env, function_name):
    result_dict = dict()
    target_function = global_env.get_value(function_name)
    target_kernel_codes = KernelCodes(target_function.raw_codes).codes
    result_dict[_INITIAL_MARK] = list()
    initial_var_dict = dict()
    for initial_var in target_function.argument_lst:
        result_dict[initial_var] = initial_var
        result_dict[_INITIAL_MARK].append(initial_var)
    for line_index in xrange(len(target_kernel_codes)):
        each_line = target_kernel_codes[line_index]
        updated_var, depended_vars = get_updated_and_depended_vars(each_line)
        if updated_var is None:
            continue
        if updated_var not in result_dict:
            result_dict[updated_var] = dict()
        for each_vars in depended_vars:
            if each_vars in initial_var_dict:
                if updated_var not in initial_var_dict:
                    initial_var_dict[updated_var] = list()
                initial_var_dict[updated_var] += initial_var_dict[each_vars]
            if each_vars not in result_dict:
                continue  # shared memory has no dependency statement
            if isinstance(result_dict[each_vars], str):
                if updated_var not in initial_var_dict:
                    initial_var_dict[updated_var] = list()
                initial_var_dict[updated_var].append(each_vars)
                continue
            for sub_line_index in result_dict[each_vars]:
                result_dict[updated_var][sub_line_index] = True
        result_dict[updated_var][line_index] = True
    for each_var in result_dict:
        if isinstance(result_dict[each_var], dict):
            result_dict[each_var] = OrderedDict(sorted(result_dict[each_var].items()))
    for each_var in initial_var_dict:
        initial_var_dict[each_var] = set(initial_var_dict[each_var])
    return result_dict, target_kernel_codes, initial_var_dict


def parse_stmt_get_involved_variable(involved_lst):
    result_lst = list()
    current_parse_lst = [item[0] for item in involved_lst]
    for each_item in current_parse_lst:
        updated_var, depended_vars = get_updated_and_depended_vars(each_item)
        if each_item.find('load') != -1:
            result_lst.append(depended_vars[0])
        else:
            result_lst.append(updated_var)
    return result_lst


def generate_depended_code_lst(target_codes, involved_lst, depended_dict):
    result_dict = dict()
    variable_lst = parse_stmt_get_involved_variable(involved_lst)
    start_index = 0
    for each_var in variable_lst:
        if each_var not in result_dict:
            result_dict[each_var] = list()
        for each_line in depended_dict[each_var]:
            # result_dict[each_var].append(each_line)
            result_dict[each_var].append((target_codes[each_line], each_line))
        if involved_lst[start_index][0].find('load') != -1:  # load can not change depended variable
            result_dict[each_var].append(involved_lst[start_index])
        start_index += 1
    return result_dict


def execute_heuristic(blocks, threads, raw_codes, arguments,
                      global_env=None, should_print=True):
    main_memory = arguments['main_memory']
    warp_size = DataType("i32")
    warp_size.set_value(32)
    global_env.add_value("@warpSize", warp_size)
    access_dict = dict()
    shared_access_dict = dict()
    current_access_dict = None
    global_access_count = 0
    shared_access_count = 0
    if global_env is None:
        global_env = Environment()
    for block_indexes in generator_for_dimension_var(blocks):
        global_env.add_value("@blockIdx", Block(block_indexes, (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        global_env.add_value("@gridDim", Block((blocks.limit_x, blocks.limit_y, blocks.limit_z),
                                               (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        local_env = Environment()
        local_env.binding_value(arguments)
        for thread_indexes in generator_for_dimension_var(threads):
            global_env.add_value("@threadIdx", Thread(thread_indexes,
                                                      (threads.limit_x, threads.limit_y, threads.limit_z)))
            global_env.add_value("@blockDim", Thread((threads.limit_x, threads.limit_y, threads.limit_z),
                                                     (threads.limit_x, threads.limit_y, threads.limit_z)))
            global_access_index = dict()
            shared_access_index = dict()
            current_access_index = None
            kernel_codes = KernelCodes(raw_codes)
            while not kernel_codes.is_over():
                current_stmt = kernel_codes.get_current_statement_and_set_next()
                if should_print:
                    print current_stmt + " in " + str(block_indexes) + " + " + str(thread_indexes)
                return_value, current_action, current_index, is_global = \
                    execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env)
                if current_action is not None:
                    if is_global:
                        current_access_dict = access_dict
                        current_access_index = global_access_index
                        global_access_count += 1
                    else:
                        current_access_dict = shared_access_dict
                        current_access_index = shared_access_index
                        shared_access_count += 1
                    if current_index not in current_access_index:
                        if current_index not in current_access_dict:
                            current_access_dict[current_index] = list()
                        current_access_dict[current_index].append(str(block_indexes) + "+" + str(thread_indexes))
                        current_access_index[current_index] = True
    return (access_dict, global_access_count), (shared_access_dict, shared_access_count)


def execute_branch_heuristic(blocks, threads, raw_codes, arguments, global_env=None, should_print=True):
    main_memory = arguments['main_memory']
    access_label_dict = dict()
    if global_env is None:
        global_env = Environment()
    for block_indexes in generator_for_dimension_var(blocks):
        global_env.add_value("@blockIdx", Block(block_indexes, (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        global_env.add_value("@gridDim", Block((blocks.limit_x, blocks.limit_y, blocks.limit_z),
                                               (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        local_env = Environment()
        local_env.binding_value(arguments)
        for thread_indexes in generator_for_dimension_var(threads):
            global_env.add_value("@threadIdx", Thread(thread_indexes,
                                                      (threads.limit_x, threads.limit_y, threads.limit_z)))
            global_env.add_value("@blockDim", Thread((threads.limit_x, threads.limit_y, threads.limit_z),
                                                     (threads.limit_x, threads.limit_y, threads.limit_z)))
            kernel_codes = KernelCodes(raw_codes)
            while not kernel_codes.is_over():
                current_stmt = kernel_codes.get_current_statement_and_set_next()
                if current_stmt.find("<label>") != -1:
                    access_label_dict[current_stmt] = True
                if should_print:
                    print current_stmt + " in " + str(block_indexes) + " + " + str(thread_indexes)
                return_value, current_action, current_index, is_global = \
                    execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env)
    return access_label_dict


def parse_initial_var_type(global_env, target_function_name):
    result_dict = dict()
    target_function = global_env.get_value(target_function_name)
    for i in xrange(len(target_function.argument_lst)):
        result_dict[target_function.argument_lst[i]] = target_function.type_lst[i]
    return result_dict


def parse_dimension(global_env, target_function_name):
    thread_dict = dict()
    block_dict = dict()
    thread_pattern = re.compile(r"threadIdx, i32 0, i32 (?P<sequence>\d+)")
    block_pattern = re.compile(r"blockIdx, i32 0, i32 (?P<sequence>\d+)")
    target_function = global_env.get_value(target_function_name)
    for each_line in target_function.raw_codes.split("\n"):
        if each_line.find("blockIdx") != -1:
            matcher = block_pattern.search(each_line)
            block_dict[matcher.group("sequence")] = True
        elif each_line.find("threadIdx") != -1:
            matcher = thread_pattern.search(each_line)
            thread_dict[matcher.group("sequence")] = True
    return [len(block_dict) if len(block_dict) != 0 else 1, len(thread_dict)]


def parse_branch_var(target_codes):
    result_lst = list()
    total_labels = 0
    for idx, each_line in enumerate(target_codes):
        if each_line.find("<label>") != -1:
            result_lst.append(idx)
            total_labels += 1
        elif each_line.find("br ") != -1:
            result_lst.append(idx)
    return result_lst, total_labels


def trace_branch_variable(branch_codes, codes):
    result_lst = list()
    branch_var_pattern = re.compile(r"br i1 (?P<var>[%]\d+), label [^\s]+, label [^\s]+")
    for index in branch_codes:
        current_line = codes[index]
        matcher = branch_var_pattern.search(current_line)
        if matcher is not None:
            result_lst.append(matcher.group("var"))
    return result_lst


def generate_branch_heuristic_code(target_file, target_function_name):
    global_env = parse_function(target_file)
    depended_vars, codes, depended_initial_var = generate_variable_depend_path(global_env, target_function_name)
    initial_var_type = parse_initial_var_type(global_env, target_function_name)
    branch_codes, total_labels = parse_branch_var(codes)
    line_lst = set()
    should_evolution = set()
    involved_branch_variable = trace_branch_variable(branch_codes, codes)
    for branch_variable in involved_branch_variable:
        if branch_variable in depended_initial_var:
            for each_initial_var in depended_initial_var[branch_variable]:
                if initial_var_type[each_initial_var].find("*") == -1:
                    should_evolution.add(each_initial_var)
        for each_line in depended_vars[branch_variable]:
            line_lst.add(each_line)
    should_evolution = list(should_evolution)
    line_lst = [(codes[item], item) for item in line_lst]
    for item in branch_codes:
        line_lst.append((codes[item], item))
    line_lst.sort(key=lambda x: x[1])
    should_evolution = [(item, initial_var_type[item]) for item in should_evolution]
    all_variable_lst = [(item, initial_var_type[item]) for item in initial_var_type
                        if initial_var_type[item].find("*") == -1]
    return line_lst, global_env, should_evolution, all_variable_lst, parse_dimension(global_env, target_function_name)


def generate_heuristic_code(target_file, target_function_name, main_memory):
    global_env = parse_function(target_file)
    depended_vars, codes, depended_initial_var = generate_variable_depend_path(global_env, target_function_name)
    initial_var_type = parse_initial_var_type(global_env, target_function_name)
    line_lst = list()
    used_line = dict()
    should_evolution = list()
    for mem_type in main_memory:
        current_mem = main_memory[mem_type]
        involved_mem_store_load = trace_target_memory(global_env, target_function_name, current_mem)
        var_code_dict = generate_depended_code_lst(codes, involved_mem_store_load, depended_vars)
        for single_var in var_code_dict:
            if single_var in depended_initial_var:
                should_evolution.append(depended_initial_var[single_var])
            for each_line in var_code_dict[single_var]:
                if each_line[1] not in used_line:
                    used_line[each_line[1]] = True
                    line_lst.append(each_line)
    for idx, each_line in enumerate(codes):
        if each_line.find("<label>") != -1:
            line_lst.append((each_line, idx))
    line_lst.sort(key=lambda x: x[1])
    should_evolution = [(item, initial_var_type[item]) for sub_list in should_evolution
                        for item in sub_list if initial_var_type[item].find("*") == -1]
    all_variable_lst = [(item, initial_var_type[item]) for item in initial_var_type
                        if initial_var_type[item].find("*") == -1]
    return line_lst, global_env, should_evolution, all_variable_lst, parse_dimension(global_env, target_function_name)


if __name__ == "__main__":
    generate_branch_heuristic_code("./kaldi-new-bug/new-func.ll", "@_Z13_copy_low_uppPfii")
    # test_lst = generate_heuristic_code("./kaldi-new-bug/new-func.ll", "@_Z13_copy_low_uppPfii", {
    #     "global": "%A"
    # })
    # print test_lst
    # global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    # test_dict, t_codes, t_depended_initial_var = generate_variable_depend_path(global_current_env, "@_Z13_copy_low_uppPfii")
    # involved_store_load = trace_target_memory(global_current_env, "@_Z13_copy_low_uppPfii", "%A")
    #
    # t_result = generate_depended_code_lst(t_codes, involved_store_load, test_dict)
    # for t_var in t_result:
    #     print t_depended_initial_var[t_var]
    # for t_var in t_result:
    #     raw_code = '\n'.join([_item[0] for _item in t_result[t_var]])
    #     print raw_code
    #     test_block = Block((-1, -1, 0), (1, 1, 1))
    #     test_thread = Thread((-1, -1, 0), (3, 1, 1))
    #     t_arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_low_uppPfii"), {"%rows": 10, "%stride": 0})
    #     t_arguments["main_memory"] = {
    #         'global': "%A",
    #         'shared': None,
    #     }
    #     generate_memory_container([], global_current_env)
    #     target_dict = execute_heuristic(test_block, test_thread, raw_code, t_arguments, global_current_env, False)
    #     print target_dict
    #     print '===================='


