import re
from DataStructure import *
from collections import OrderedDict
from DetectBug import parse_function
from StatementExecutor import parse_arguments


def parse_all_variable_from_string(target_string):
    result_lst = list()
    for single_var in re.finditer(r"%\w+", target_string):
        real_var = target_string[single_var.start(): single_var.end()]
        if real_var.find("%struct") == -1:
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
        updated_var = all_vars[1]
        depended_vars = [all_vars[0]]
    return updated_var, depended_vars


def list_item_in_dict(target_lst, target_dict):
    for item  in target_lst:
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
                    result_lst.append(each_line)  # real load
            elif each_line.find('getelementptr') != -1:
                variable_set[updated_var] = True
    return result_lst


def generate_variable_depend_path(global_env, function_name):
    result_dict = dict()
    target_function = global_env.get_value(function_name)
    target_kernel_codes = KernelCodes(target_function.raw_codes).codes
    for initial_var in target_function.argument_lst:
        result_dict[initial_var] = initial_var
    for line_index in xrange(len(target_kernel_codes)):
        each_line = target_kernel_codes[line_index]
        updated_var, depended_vars = get_updated_and_depended_vars(each_line)
        if updated_var is None:
            continue
        if updated_var not in result_dict:
            result_dict[updated_var] = dict()
        for each_vars in depended_vars:
            if isinstance(result_dict[each_vars], str):
                continue
            for sub_line_index in result_dict[each_vars]:
                result_dict[updated_var][sub_line_index] = True
        result_dict[updated_var][line_index] = True
    for each_var in result_dict:
        if isinstance(result_dict[each_var], dict):
            result_dict[each_var] = OrderedDict(sorted(result_dict[each_var].items()))
    return result_dict, target_kernel_codes


def parse_stmt_get_involved_variable(involved_lst):
    result_lst = list()
    for each_item in involved_lst:
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
            result_dict[each_var].append(target_codes[each_line])
        if involved_lst[start_index].find('load') != -1: # load can not change depended variable
            result_dict[each_var].append(involved_lst[start_index])
        start_index += 1
    return result_dict


if __name__ == "__main__":
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    test_dict, codes = generate_variable_depend_path(global_current_env, "@_Z13_copy_low_uppPfii")
    involved_store_load = trace_target_memory(global_current_env, "@_Z13_copy_low_uppPfii", "%A")

    t_result = generate_depended_code_lst(codes, involved_store_load, test_dict)
    for t_var in t_result:
        for t_line in t_result[t_var]:
            print t_line
        print '===================='


