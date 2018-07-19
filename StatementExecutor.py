import re
from DataStructure import *


def num(s):
    try:
        return int(s)
    except ValueError:
        return float(s)


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
        return True # is shared memory
    return False


# 2 type: struct, memory index, return value has two kinds: one is actually value of struct, the other is memory index
def get_element_ptr(arguments, kernel_codes, main_memory, global_env, local_env):
    local_arguments = arguments.replace("inbounds", "")
    local_arguments = local_arguments.replace("(", "")
    local_arguments = local_arguments.replace(")", "")
    local_arguments = local_arguments.split(",")
    target = execute_item(local_arguments[0], kernel_codes, global_env, local_env)
    local_arguments = [item for item in local_arguments if item.find('!dbg') == -1 and item.find('align') == -1]
    tmp_index = execute_item(local_arguments[-1], kernel_codes, global_env, local_env)
    if is_memory(target):
        result_tmp = DataType('memory-index')
        result_tmp.set_is_getelementptr(True)
        result_tmp.set_memory_index(num(tmp_index.get_value()))
        result_tmp.set_value(target.get_value())
        return result_tmp, None, None, None
    else:
        return target.get_value()[num(tmp_index.get_value())], None, None, None


def store(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    arguments = arguments.split(',')
    source = execute_command(arguments[0], kernel_codes, main_memory, global_env, local_env)[0]
    target = execute_command(arguments[1], kernel_codes, main_memory, global_env, local_env)[0]
    if is_target_memory(target, main_memory) and target.memory_index is not None:
        return source, "write", target.memory_index, is_global_memory(target)
    else:
        var_lst = arguments[1].strip()
        var_lst = var_lst.split(' ')
        if var_lst[1][0] == '@':
            global_env.add_value(var_lst[1], source)
        else:
            local_env.add_value(var_lst[1], source)
        return source, None, None, None


def load(arguments, kernel_codes, main_memory, global_env, local_env):
    arguments = arguments.strip()
    split_index = arguments.find(' ')
    target_command = arguments[split_index + 1:]
    if target_command.find('getelementptr') != -1:
        result = execute_command(arguments[split_index + 1:], kernel_codes, main_memory, global_env, local_env)[0]
    else:
        result = execute_item(target_command.split(',')[0], kernel_codes, global_env, local_env)
    if is_target_memory(result, main_memory) and result.memory_index is not None:
        result.set_is_depend_on_running_time(True)
        return result, "read", result.memory_index, is_global_memory(result)
    return result, None, None, None


def parse_arguments(target_args):
    result = list()
    # todo
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
    argus_value = [execute_command(single_value[1], kernel_codes, main_memory, global_env, local_env)
                   for single_value in argus_value]
    kernel_codes.prepared_launch_function(local_env, target_function.codes, argus_value)
    return None, None, None, None


def calculation_factory(cac_flag):
    #  cac_flag = 0 -> +, 1 -> -, 2 -> *, 3 -> \, 4 -> %
    def __cal(arguments, kernel_codes, main_memory, global_env, local_env):
        arguments = arguments.replace("nsw", "")
        arguments = arguments.strip()
        arguments = arguments.split(',')
        var_lst = arguments[0].strip().split(' ')
        tmp_result = DataType(var_lst[0].strip())
        number_one = execute_item(var_lst[1].strip(), kernel_codes, global_env, local_env)
        number_two = execute_item(arguments[1], kernel_codes, global_env, local_env)
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
        return tmp_result, None, None, None
    return __cal


def single_elem_calculation_factory(cac_flag):
    #  cal_flag: 0->sext
    def __cal(arguments, kernel_codes, main_memory, global_env, local_env):
        arguments = arguments.strip()
        arguments = arguments.split(' ')
        old_data = execute_item(arguments[1], kernel_codes, global_env, local_env)
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
    number_one = execute_item(actual_arguments[0], kernel_codes, global_env, local_env)
    number_two = execute_item(actual_arguments[1], kernel_codes, global_env, local_env)
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
        bool_res = execute_item(new_line[0], kernel_codes, global_env, local_env)
        if_true = new_line[1][new_line[1].find('%') + 1:]
        if_false = new_line[2][new_line[2].find('%') + 1:]
        if bool(bool_res.get_value()):
            kernel_codes.set_next_statement(kernel_codes.get_label_by_mark(if_true))
        else:
            kernel_codes.set_next_statement(kernel_codes.get_label_by_mark(if_false))
    return None, None, None, None


_method_dict = {
    'alloca': alloc_type_for_var,
    'getelementptr': get_element_ptr,
    'store': store,
    'load': load,
    'call': call_function,
    'add': calculation_factory(0),
    'mul': calculation_factory(2),
    'srem': calculation_factory(4),
    'sext': single_elem_calculation_factory(0),
    'icmp': compare_expression,
    'br': jump,
}


def execute_item(statement, kernel_codes, global_env, local_env):
    statement = statement.strip()
    split_index = statement.find(' ')
    if split_index == -1:
        data_type = None
        data_token = statement
    else:
        data_type = statement[: split_index].strip()
        data_token = statement[split_index:].strip()
    if global_env.has_given_key(data_token):
        return global_env.get_value(data_token)
    if local_env.has_given_key(data_token):
        return local_env.get_value(data_token)
    if re.match(r"^\d+$", data_token):
        result_tmp = DataType("i32")
        result_tmp.set_value(num(data_token))
        return result_tmp
    result_tmp = DataType(data_type)
    result_tmp.set_value(data_token)
    return result_tmp


def execute_command(statement, kernel_codes, main_memory, global_env, local_env):
    statement = statement.strip()
    split_index = statement.find(' ')
    operator = statement[: split_index].strip()
    arguments = statement[split_index:].strip()
    if operator not in _method_dict:
        return execute_item(statement, kernel_codes, global_env, local_env), None, None, None
    return _method_dict[operator](arguments, kernel_codes, main_memory, global_env, local_env)


def execute_assign(statement, kernel_codes, main_memory, global_env, local_env):
    tmp_arr = statement.split("=")
    target_var = tmp_arr[0].strip()
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
    test_code = '''
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %i = alloca i32, align 4
  %index = alloca i32, align 4
  %sum = alloca float, align 4
  %j = alloca i32, align 4
  %m = alloca i32, align 4
  store float* %A, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !976), !dbg !977
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !978), !dbg !977
  store float* %value, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !979), !dbg !977
  store i32 %dim, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !980), !dbg !977
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !981), !dbg !983
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !983
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !983
  %7 = mul i32 %5, %6, !dbg !983
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !983
  %9 = add i32 %7, %8, !dbg !983
  store i32 %9, i32* %i, align 4, !dbg !983
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !984), !dbg !985
  %10 = load i32* %i, align 4, !dbg !985
  %11 = load i32* %i, align 4, !dbg !985
  %12 = add nsw i32 %11, 1, !dbg !985
  %13 = mul nsw i32 %10, %12, !dbg !985
  %14 = sdiv i32 %13, 2, !dbg !985
  store i32 %14, i32* %index, align 4, !dbg !985
  %15 = load i32* %i, align 4, !dbg !986
  %16 = load i32* %4, align 4, !dbg !986
  %17 = icmp slt i32 %15, %16, !dbg !986
  br i1 %17, label %18, label %82, !dbg !986

; <label>:18                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{float* %sum}, metadata !987), !dbg !989
  store float 0.000000e+00, float* %sum, align 4, !dbg !989
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !990), !dbg !992
  store i32 0, i32* %j, align 4, !dbg !992
  br label %19, !dbg !992

; <label>:19                                      ; preds = %42, %18
  %20 = load i32* %j, align 4, !dbg !992
  %21 = load i32* %i, align 4, !dbg !992
  %22 = icmp slt i32 %20, %21, !dbg !992
  br i1 %22, label %23, label %45, !dbg !992

; <label>:23                                      ; preds = %19
  %24 = load float* %sum, align 4, !dbg !993
  %25 = load i32* %index, align 4, !dbg !993
  %26 = load i32* %j, align 4, !dbg !993
  %27 = add nsw i32 %25, %26, !dbg !993
  %28 = sext i32 %27 to i64, !dbg !993
  %29 = load float** %1, align 8, !dbg !993
  %30 = getelementptr inbounds float* %29, i64 %28, !dbg !993
  %31 = load float* %30, align 4, !dbg !993
  %32 = load i32* %index, align 4, !dbg !993
  %33 = load i32* %j, align 4, !dbg !993
  %34 = add nsw i32 %32, %33, !dbg !993
  %35 = sext i32 %34 to i64, !dbg !993
  %36 = load float** %2, align 8, !dbg !993
  %37 = getelementptr inbounds float* %36, i64 %35, !dbg !993
  %38 = load float* %37, align 4, !dbg !993
  %39 = fmul float %31, %38, !dbg !993
  %40 = fmul float 2.000000e+00, %39, !dbg !993
  %41 = fadd float %24, %40, !dbg !993
  store float %41, float* %sum, align 4, !dbg !993
  br label %42, !dbg !995

; <label>:42                                      ; preds = %23
  %43 = load i32* %j, align 4, !dbg !992
  %44 = add nsw i32 %43, 1, !dbg !992
  store i32 %44, i32* %j, align 4, !dbg !992
  br label %19, !dbg !992

; <label>:45                                      ; preds = %19
  %46 = load float* %sum, align 4, !dbg !996
  %47 = load i32* %index, align 4, !dbg !996
  %48 = load i32* %i, align 4, !dbg !996
  %49 = add nsw i32 %47, %48, !dbg !996
  %50 = sext i32 %49 to i64, !dbg !996
  %51 = load float** %1, align 8, !dbg !996
  %52 = getelementptr inbounds float* %51, i64 %50, !dbg !996
  %53 = load float* %52, align 4, !dbg !996
  %54 = load i32* %index, align 4, !dbg !996
  %55 = load i32* %i, align 4, !dbg !996
  %56 = add nsw i32 %54, %55, !dbg !996
  %57 = sext i32 %56 to i64, !dbg !996
  %58 = load float** %2, align 8, !dbg !996
  %59 = getelementptr inbounds float* %58, i64 %57, !dbg !996
  %60 = load float* %59, align 4, !dbg !996
  %61 = fmul float %53, %60, !dbg !996
  %62 = fadd float %46, %61, !dbg !996
  store float %62, float* %sum, align 4, !dbg !996
  call void @llvm.dbg.declare(metadata !{i32* %m}, metadata !997), !dbg !999
  store i32 0, i32* %m, align 4, !dbg !999
  br label %63, !dbg !999

; <label>:63                                      ; preds = %70, %45
  %64 = load i32* %m, align 4, !dbg !999
  %65 = icmp slt i32 %64, 255, !dbg !999
  br i1 %65, label %66, label %73, !dbg !999

; <label>:66                                      ; preds = %63
  %67 = load i32* %m, align 4, !dbg !1000
  %68 = sext i32 %67 to i64, !dbg !1000
  %69 = getelementptr inbounds [256 x double]* @_ZZL15_trace_sp_sp_fdIfEvPKfPKT_PfiE8row_data, i32 0, i64 %68, !dbg !1000
  store double 0.000000e+00, double* %69, align 8, !dbg !1000
  br label %70, !dbg !1000

; <label>:70                                      ; preds = %66
  %71 = load i32* %m, align 4, !dbg !999
  %72 = add nsw i32 %71, 1, !dbg !999
  store i32 %72, i32* %m, align 4, !dbg !999
  br label %63, !dbg !999

; <label>:73                                      ; preds = %63
  %74 = load float* %sum, align 4, !dbg !1001
  %75 = fpext float %74 to double, !dbg !1001
  %76 = load i32* %i, align 4, !dbg !1001
  %77 = sext i32 %76 to i64, !dbg !1001
  %78 = getelementptr inbounds [256 x double]* @_ZZL15_trace_sp_sp_fdIfEvPKfPKT_PfiE8row_data, i32 0, i64 %77, !dbg !1001
  store double %75, double* %78, align 8, !dbg !1001
  call void @__syncthreads(), !dbg !1002
  %79 = call double @_ZL11_sum_reduceIdET_PS0_(double* getelementptr inbounds ([256 x double]* @_ZZL15_trace_sp_sp_fdIfEvPKfPKT_PfiE8row_data, i32 0, i32 0)), !dbg !1003
  %80 = fptrunc double %79 to float, !dbg !1003
  %81 = load float** %3, align 8, !dbg !1003
  store float %80, float* %81, align 4, !dbg !1003
  br label %82, !dbg !1004

; <label>:82                                      ; preds = %73, %0
  ret void, !dbg !1005
        '''
    kernel = KernelCodes(test_code)
    execute_statement_and_get_action(kernel, Environment(), Environment())
