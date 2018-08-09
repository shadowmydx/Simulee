from DataStructure import *
from MainProcess import construct_memory_execute_mode
from MainProcess import parse_target_memory_and_checking_sync
import random


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
    generate_memory_container(["@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"], global_current_env)

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
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 2))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_from_tpPfPKfiii"), {
        "%dmat_rows": 10,
        "%dmat_cols": 10,
        "%dmat_stride": 1,
    })
    arguments["main_memory"] = {
        'global': "%A",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z13_copy_from_tpPfPKfiii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, True)


def test_copy_from_mat():
    test_block = Block((-1, -1, 0), (2, 2, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 2))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z14_copy_from_matPfPKfiiii"), {
        "%d_out_stride": 1,
        "%d_out_rows": 5,
        "%d_out_cols": 5,
        "%d_in_stride": 1,
    })
    arguments["main_memory"] = {
        'global': "%mat_out",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z14_copy_from_matPfPKfiiii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_trace_mat_mat_trans():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (40, 1, 1))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z20_trace_mat_mat_transPKfS0_iiiiPf"), {
        "%dA_rows": 5,
        "%dA_cols": 5,
        "%dA_stride": 1,
        "%B_stride": 1,
    })
    arguments["main_memory"] = {
        'global': None, # "%value",
        'shared': "@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum",
    }
    generate_memory_container(["@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"], global_current_env)

    raw_code = global_current_env.get_value("@_Z20_trace_mat_mat_transPKfS0_iiiiPf")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def generate_random_data_for_memory(target_memory_container, target_memory, total_size):
    low_bound = 1
    high_bound = 100
    for index in xrange(total_size):
        memory_shell = DataType("..")
        memory_shell.memory_index = index
        memory_shell.set_value(target_memory)
        current_data = DataType("i32")
        current_data.set_value(random.randint(low_bound, high_bound))
        target_memory_container.add_value_to_memory(memory_shell, current_data)


def test_slice():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 1))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z7_splicePfPKfPKiiiiiii"), {
        "%d_out_cols": 5,
        "%d_out_rows": 5,
        "%d_out_stride": 1,
        "%d_in_cols": 5,
        "%d_in_rows": 5,
        "%d_in_stride": 1,
    })
    arguments["main_memory"] = {
        'global': "%y",
        'shared': None,
    }
    generate_memory_container(["%off"], global_current_env)
    target_memory = global_current_env.get_value("memory_container")
    generate_random_data_for_memory(target_memory, "%off", 100)
    raw_code = global_current_env.get_value("@_Z7_splicePfPKfPKiiiiiii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


if __name__ == "__main__":
    # global_test_env = parse_function("./kaldi-new-bug/new-func.ll")
    # test_copy_low_upp()
    # test_copy_upp_low()
    # test_add_diag_vec_mat()
    test_copy_from_tp()
    # test_copy_from_mat()
    # test_trace_mat_mat_trans()
    # test_slice()
    print 'over'

