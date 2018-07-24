import re
from DataStructure import *


def num(s):
    try:
        return int(s)
    except ValueError:
        return float(s)


def find_the_correct_space(target_str):
    get_index = target_str.find('getelementptr')
    if get_index != -1:
        return get_index - 1
    start_index = 0
    space_index = -1
    while start_index < len(target_str):
        if target_str[start_index] == ' ':
            space_index = start_index
        start_index += 1
    return space_index


def detect_if_is_syncthreads(statement):
    return statement.find("call void @__syncthreads()") != -1


def alloc_type_for_var(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.split(',')
    type_name = arguments[0].strip()
    new_type = DataType(type_name)
    return new_type, None, None, None


def is_memory(data_type):
    if data_type.value is None:
        return False
    try:
        return data_type.value[0] == '%' or data_type.value[0] == '@'
    except:
        return False


def is_global_memory(data_type):
    try:
        return data_type.value[0] == '%'
    except:
        return False


def is_target_memory(data_type, main_memory):
    if data_type.value == main_memory:
        return True
    if not is_global_memory(data_type) and is_memory(data_type):
        return True  # is shared memory
    return False


# 2 type: struct, memory index, return value has two kinds: one is actually value of struct, the other is memory index
def get_element_ptr(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    local_arguments = arguments.replace("inbounds", "")
    local_arguments = local_arguments.replace("(", "")
    local_arguments = local_arguments.replace(")", "")
    local_arguments = local_arguments.split(",")
    target = execute_item(local_arguments[0], kernel_codes, main_memory, global_env, local_env)
    local_arguments = [item for item in local_arguments if item.find('!dbg') == -1 and item.find('align') == -1]
    tmp_index = execute_item(local_arguments[-1], kernel_codes, main_memory, global_env, local_env)
    if is_memory(target):
        result_tmp = DataType('memory-index')
        result_tmp.set_is_getelementptr(True)
        if not tmp_index.is_depend_on_running_time:
            result_tmp.set_memory_index(num(tmp_index.get_value()))
        else:
            result_tmp.set_memory_index(None)
        result_tmp.set_value(target.get_value())
        return result_tmp, None, None, None
    else:
        return target.get_value()[num(tmp_index.get_value())], None, None, None


# todo
# need distinguish target is a register or memory
def store(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    arguments = parse_arguments(arguments)
    source = execute_command(arguments[0], kernel_codes, main_memory, global_env, local_env)[0]
    target = execute_command(arguments[1], kernel_codes, main_memory, global_env, local_env)[0]
    if is_target_memory(target, main_memory) and target.memory_index is not None and target.is_getelementptr is True:
        if arguments[1].find("**") == -1:
            return source, "write", target.memory_index, is_global_memory(target)
        return source, None, None, None
    else:
        var_lst = arguments[1].strip()
        var_lst = var_lst.split(' ')
        if var_lst[1][0] == '@':
            global_env.add_value(var_lst[1], source)
        else:
            local_env.add_value(var_lst[1], source)
        return source, None, None, None


# todo
# need distinguish result is a register or memory
def load(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    split_index = arguments.find(' ')
    target_command = arguments[split_index + 1:]
    target_type = arguments[: split_index]
    if target_command.find('getelementptr') != -1:
        result = execute_command(arguments[split_index + 1:], kernel_codes, main_memory, global_env, local_env)[0]
    else:
        result = execute_item(target_command.split(',')[0], kernel_codes, main_memory, global_env, local_env)
    if is_target_memory(result, main_memory) and result.memory_index is not None and result.is_getelementptr is True \
            and result.is_depend_on_running_time is False:  # haven't been loaded to register
        result.set_is_depend_on_running_time(True)
        if target_type.find("**") == -1:
            return result, "read", result.memory_index, is_global_memory(result)
        return result, None, None, None
    if is_memory(result):
        result.set_is_depend_on_running_time(True)
    return result, None, None, None


def parse_arguments(target_args):
    result = list()
    # todo: parse argument string list ['(type token)|command', ...]
    start_index = 0
    tmp_result = ''
    while start_index != len(target_args):
        if target_args[start_index] == '(':
            tmp_result += target_args[start_index]
            start_param = 1
            start_index += 1
            while start_param != 0:
                tmp_result += target_args[start_index]
                if target_args[start_index] == '(':
                    start_param += 1
                elif target_args[start_index] == ')':
                    start_param -= 1
                start_index += 1
        elif target_args[start_index] == ',':
            result.append(tmp_result)
            tmp_result = ''
            start_index += 1
        else:
            tmp_result += target_args[start_index]
            start_index += 1
    result.append(tmp_result)
    for index in xrange(len(result)):
        element_index = result[index].find('getelementptr')
        if element_index != -1:
            result[index] = result[index][element_index:]
    return result


def call_function(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    split_index = arguments.find(' ')
    target_function_pattern = r"(?P<function_name>[^(]+)\((?P<argus>.*)\)"
    target_function_pattern = re.compile(target_function_pattern, re.DOTALL)
    arguments = arguments[split_index + 1:]
    matcher = target_function_pattern.search(arguments)
    target_function = global_env.get_value(matcher.group('function_name'))
    if target_function is None:
        return None, None, None, None
    argus_value = matcher.group('argus')
    argus_value = parse_arguments(argus_value)
    argus_value = [execute_command(single_value, kernel_codes, main_memory, global_env, local_env)[0]
                   for single_value in argus_value]
    argus_dict = dict()
    value_index = 0
    for key in target_function.argument_lst:
        argus_dict[key] = argus_value[value_index]
        value_index += 1
    kernel_codes.prepared_launch_function(local_env, KernelCodes(target_function.raw_codes), argus_dict)
    return None, None, None, None


def return_statement(arguments, kernel_codes, main_memory, global_env, local_env):
    if arguments.find('void') != -1:
        kernel_codes.restore_after_execution_function(local_env)
        return None, None, None, None
    else:
        arguments = arguments.strip()
        arguments = arguments.split(',')[0]
        split_index = arguments.find(' ')
        arguments = arguments[split_index + 1:].strip()
        result = execute_item(arguments, kernel_codes, main_memory, global_env, local_env)
        kernel_codes.set_return_value(result)
        kernel_codes.restore_after_execution_function(local_env)
        return result, None, None, None


def calculation_factory(cac_flag):
    #  cac_flag = 0 -> +, 1 -> -, 2 -> *, 3 -> \, 4 -> %, 5 _> >>
    def __cal(arguments, kernel_codes, main_memory, global_env, local_env):
        arguments = arguments.replace("nsw", "")
        arguments = arguments.strip()
        arguments = arguments.split(',')
        var_lst = arguments[0].strip().split(' ')
        tmp_result = DataType(var_lst[0].strip())
        number_one = execute_item(var_lst[1].strip(), kernel_codes, main_memory, global_env, local_env)
        number_two = execute_item(arguments[1], kernel_codes, main_memory, global_env, local_env)
        if number_one.is_depend_on_running_time or number_two.is_depend_on_running_time:
            tmp_result.set_is_depend_on_running_time(True)
            return tmp_result, None, None, None
        if cac_flag == 0:
            tmp_result.set_value(num(number_one.get_value()) + num(number_two.get_value()))
        elif cac_flag == 1:
            tmp_result.set_value(num(number_one.get_value()) - num(number_two.get_value()))
        elif cac_flag == 2:
            tmp_result.set_value(num(number_one.get_value()) * num(number_two.get_value()))
        elif cac_flag == 3:
            tmp_result.set_value(num(number_one.get_value()) / num(number_two.get_value()))
        elif cac_flag == 4:
            tmp_result.set_value(num(number_one.get_value()) % num(number_two.get_value()))
        elif cac_flag == 5:
            tmp_result.set_value(num(number_one.get_value()) >> num(number_two.get_value()))
        return tmp_result, None, None, None
    return __cal


def single_elem_calculation_factory(cac_flag):
    #  cal_flag: 0->sext, bitcast, sitofp
    def __cal(arguments, kernel_codes, main_memory, global_env, local_env):
        arguments = arguments.strip()
        arguments = arguments.split(' ')
        old_data = execute_item(arguments[1], kernel_codes, main_memory, global_env, local_env)
        new_data = DataType('..')
        old_data.copy_and_replace(new_data)
        new_data.set_type(arguments[3])
        return new_data, None, None, None
    return __cal


def compare_expression(arguments, kernel_codes, main_memory, global_env, local_env):
    result_tmp = DataType('bool')
    oper_dict = {
        'eq': lambda x, y: x == y,
        'ne': lambda x, y: x != y,
        'gt': lambda x, y: x > y,
        'ge': lambda x, y: x >= y,
        'lt': lambda x, y: x < y,
        'le': lambda x, y: x <= y,
    }
    arguments = arguments.strip()
    split_index = arguments.find(' ')
    operator, actual_arguments = arguments[: split_index], arguments[split_index + 1:]
    if len(operator) > 2:
        operator = operator[1:]
    split_index = actual_arguments.find(' ')
    actual_arguments = actual_arguments[split_index + 1:]
    actual_arguments = actual_arguments.split(',')
    number_one = execute_item(actual_arguments[0], kernel_codes, main_memory, global_env, local_env)
    number_two = execute_item(actual_arguments[1], kernel_codes, main_memory, global_env, local_env)
    if number_two.is_depend_on_running_time or number_one.is_depend_on_running_time:
        result_tmp.set_is_depend_on_running_time(True)
    else:
        result_tmp.set_value(oper_dict[operator](num(number_one.get_value()), num(number_two.get_value())))
    return result_tmp, None, None, None


def jump(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    split_index = arguments.find(' ')
    if arguments[:split_index].find('label') != -1:
        new_line = arguments[split_index + 1:].split(',')[0]
        new_line = new_line[1:]
        kernel_codes.set_next_statement(kernel_codes.get_label_by_mark(new_line))
    else:
        new_line = arguments[split_index + 1:].strip()
        new_line = new_line.split(',')
        bool_res = execute_item(new_line[0], kernel_codes, main_memory, global_env, local_env)
        if_true = new_line[1][new_line[1].find('%') + 1:]
        if_false = new_line[2][new_line[2].find('%') + 1:]
        if bool(bool_res.get_value()):
            kernel_codes.set_next_statement(kernel_codes.get_label_by_mark(if_true))
        else:
            kernel_codes.set_next_statement(kernel_codes.get_label_by_mark(if_false))
    return None, None, None, None


def phi(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    split_index = arguments.find(' ')
    should_handle = arguments[split_index + 1:].strip()
    argus_pattern = r"\[ (?P<value1>[^\s]+), (?P<label1>[^\s+]) \], \[ (?P<value2>[^\s+]), (?P<label2>[^\s]+) \]"
    argus_pattern = re.compile(argus_pattern)
    matcher = argus_pattern.search(should_handle)
    recent_label = '%' + kernel_codes.get_recently_label()
    if recent_label == matcher.group("label1"):
        return execute_command(matcher.group("value1"), kernel_codes,  main_memory, global_env, local_env)
    else:
        return execute_command(matcher.group("value2"), kernel_codes, main_memory, global_env, local_env)


_method_dict = {
    'alloca': alloc_type_for_var,
    'getelementptr': get_element_ptr,
    'store': store,
    'load': load,
    'call': call_function,
    'add': calculation_factory(0),
    'fadd': calculation_factory(0),
    'sub': calculation_factory(1),
    'fsub': calculation_factory(1),
    'mul': calculation_factory(2),
    'fmul': calculation_factory(2),
    'div': calculation_factory(3),
    'fdiv': calculation_factory(3),
    'udiv': calculation_factory(3),
    'srem': calculation_factory(4),
    'ashr': calculation_factory(5),
    'sext': single_elem_calculation_factory(0),
    'zext': single_elem_calculation_factory(0),
    'bitcast': single_elem_calculation_factory(0),
    'sitofp': single_elem_calculation_factory(0),
    'icmp': compare_expression,
    'fcmp': compare_expression,
    'br': jump,
    'ret': return_statement,
    'phi': phi,
}


def execute_item(statement, kernel_codes, main_memory, global_env, local_env):
    statement = statement.strip()
    split_index = find_the_correct_space(statement)
    if split_index == -1:
        data_type = None
        data_token = statement
    else:
        data_type = statement[: split_index].strip()
        data_token = statement[split_index:].strip()
    if data_token.find('getelementptr') != -1:
        return execute_command(data_token, kernel_codes, main_memory, global_env, local_env)[0]
    if global_env.has_given_key(data_token):
        return global_env.get_value(data_token)
    if local_env.has_given_key(data_token):
        return local_env.get_value(data_token)
    if re.match(r"^\d+$", data_token):
        result_tmp = DataType("i32")
        result_tmp.set_value(num(data_token))
        return result_tmp
    if data_token == 'true' or data_token == 'false':
        result_tmp = DataType("boolean")
        result_tmp.set_value(bool(data_token))
        return result_tmp
    try:
        real_value = num(data_token)
        result_tmp = DataType(data_type)
        result_tmp.set_value(real_value)
        return result_tmp
    except:
        result_tmp = DataType(data_type)
        result_tmp.set_value(data_token)
        return result_tmp


def execute_command(statement, kernel_codes, main_memory, global_env, local_env):
    statement = statement.strip()
    split_index = statement.find(' ')
    operator = statement[: split_index].strip()
    arguments = statement[split_index:].strip()
    if operator not in _method_dict:
        return execute_item(statement, kernel_codes, main_memory, global_env, local_env), None, None, None
    return _method_dict[operator](arguments, kernel_codes, main_memory, global_env, local_env)


def execute_assign(statement, kernel_codes, main_memory, global_env, local_env):
    tmp_arr = statement.split("=")
    target_var = tmp_arr[0].strip()
    if '='.join(tmp_arr[1:]).find("call") != -1:
        kernel_codes.set_need_return_token(str(target_var))
    return_value, action, current_index, is_global = execute_command('='.join(tmp_arr[1:]),
                                                                     kernel_codes, main_memory, global_env, local_env)
    local_env.add_value(str(target_var), return_value)
    return return_value, action, current_index, is_global


def execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env):
    if len(re.findall(r"(@|%)\w+\s*=\s*(.*)", current_stmt, re.DOTALL)) != 0:
        return execute_assign(current_stmt, kernel_codes, main_memory, global_env, local_env)
    else:
        return execute_command(current_stmt, kernel_codes, main_memory, global_env, local_env)


if __name__ == '__main__':
    print parse_arguments("double* getelementptr inbounds ([256 x double]* @_ZZL15_trace_sp_sp_fdIfEvPKfPKT_PfiE8row_data, i32 0, i32 0), int* %32")
