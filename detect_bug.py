from DataStructure import *
from MainProcess import construct_memory_execute_mode
from MainProcess import parse_target_memory_and_checking_sync


def count_star(target_str):
    star_numbers = 0
    for single_char in target_str:
        if single_char == '*':
            star_numbers += 1
    return star_numbers


def generate_arguments(target_function, value_dict=None):
    result_arg = dict()
    for current_index in xrange(len(target_function.type_lst)):
        current_arg = target_function.argument_lst[current_index]
        current_type = target_function.type_lst[current_index]
        target_type = DataType(current_type)
        if count_star(current_type) == 1:
            target_type.set_value(current_arg)
        if value_dict is not None and current_arg in value_dict:
            target_type.set_value(value_dict[current_arg])
        result_arg[current_arg] = target_type
    return result_arg


def generate_memory_container(shared_memory_lst, global_env):
    memory_container = MemoryContainer()
    for item in shared_memory_lst:
        memory_container.add_new_memory(item)
    global_env.add_value("memory_container", memory_container)


def parse_function(target_file):
    global_env = Environment()
    Function.read_function_from_file_include_struct(target_file, global_env)
    return global_env


def test_copy_low_upp():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 2))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_low_uppPfii"), {"%rows": 5, "%stride": 0})
    arguments["main_memory"] = {
        'global': "%A",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z13_copy_low_uppPfii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, True)


def test_copy_upp_low():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 2))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_upp_lowPfii"), {"%rows": 5, "%stride": 0})
    arguments["main_memory"] = {
        'global': "%A",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z13_copy_low_uppPfii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, True)


def test_add_diag_vec_mat():
    test_block = Block((-1, -1, 0), (2, 2, 2))
    test_thread = Thread((-1, -1, 0), (3, 2, 2))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z17_add_diag_vec_matfPfiiiPKfS1_iif"), {
        "%rows": 5,
        "%cols": 5,
        "%stride": 1,
        "%alpha": 1.0,
        "%beta": 1.0,
        "%mat2_row_stride": 1,
        "%mat2_col_stride": 1,
    })
    arguments["main_memory"] = {
        'global': "%mat",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z17_add_diag_vec_matfPfiiiPKfS1_iif")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, True)


def test_copy_from_tp():
    test_block = Block((-1, -1, 0), (2, 2, 2))
    test_thread = Thread((-1, -1, 0), (3, 2, 2))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_from_tpPfPKfiii"), {
        "%dmat_rows": 5,
        "%dmat_cols": 5,
        "%dmat_stride": 0,
    })
    arguments["main_memory"] = {
        'global': "%A",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z17_add_diag_vec_matfPfiiiPKfS1_iif")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, True)


if __name__ == "__main__":
    # global_test_env = parse_function("./kaldi-new-bug/new-func.ll")
    # test_copy_low_upp()
    # test_copy_upp_low()
    # test_add_diag_vec_mat()
    test_copy_from_tp()
    print 'over'

