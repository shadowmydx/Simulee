from DataStructure import *
from MainProcess import construct_memory_execute_mode
from MainProcess import construct_memory_execute_mode_for_barrier
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
    test_block = Block((-1, -1, 0), (2, 3, 1))
    test_thread = Thread((-1, -1, 0), (5, 5, 1))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_low_uppPfii"), {"%rows": 23, "%stride": 1})
    arguments["main_memory"] = {
        'global': "%A",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z13_copy_low_uppPfii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_copy_upp_low():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (2, 3, 1))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13_copy_upp_lowPfii"), {"%rows": 5, "%stride": 0})
    arguments["main_memory"] = {
        'global': "%A",
        'shared': None,
    }
    generate_memory_container(["@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"], global_current_env)

    raw_code = global_current_env.get_value("@_Z13_copy_upp_lowPfii")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_add_diag_vec_mat():
    test_block = Block((-1, -1, 0), (1, 3, 1))
    test_thread = Thread((-1, -1, 0), (5, 5, 1))
    global_current_env = parse_function("./kaldi-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z17_add_diag_vec_matfPfiiiPKfS1_iif"), {
        "%rows": 3,
        "%cols": 16,
        "%stride": 1,
        "%alpha": 1.0,
        "%beta": 1.0,
        "%mat2_row_stride": 7,
        "%mat2_col_stride": 9,
    })
    arguments["main_memory"] = {
        'global': "%mat",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z17_add_diag_vec_matfPfiiiPKfS1_iif")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_copy_from_tp():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 1))
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
                                  global_current_env, False)


def test_copy_from_mat():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (3, 2, 1))
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


def generate_random_float_data_for_memory(target_memory_container, target_memory, total_size):
    for index in xrange(total_size):
        memory_shell = DataType("..")
        memory_shell.memory_index = index
        memory_shell.set_value(target_memory)
        current_data = DataType("float")
        current_data.set_value(random.random())
        target_memory_container.add_value_to_memory(memory_shell, current_data)


def fill_data_to_memory_by_list(target_memory_container, target_memory, data_list):
    for index in xrange(len(data_list)):
        memory_shell = DataType("..")
        memory_shell.memory_index = index
        memory_shell.set_value(target_memory)
        current_data = DataType("i32")
        current_data.set_value(data_list[index])
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


def test_convnet_kReflectH():
    test_block = Block((-1, -1, 0), (1, 1, 1))
    test_thread = Thread((-1, -1, 0), (34, 4, 1))
    global_current_env = parse_function("./cuda-convnet2-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z9kReflectHPfS_iiiib"), {
        "%imgSize": 5,
        "%numCases": 5,
        "%numColors": 1,
        "%imgsPerThread": 1,
        "%checkCaseBounds": 1,
    })
    arguments["main_memory"] = {
        'global': "%target",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z9kReflectHPfS_iiiib")
    construct_memory_execute_mode(test_block, test_thread, 256, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_convnet_kTile():
    test_block = Block((-1, -1, 0), (2, 2, 1))  # important
    test_thread = Thread((-1, -1, 0), (3, 1, 1))
    global_current_env = parse_function("./cuda-convnet2-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z5kTilePKfPfjjjj"), {
        "%srcWidth": 5,
        "%srcHeight": 5,
        "%tgtWidth": 5,
        "%tgtHeight": 5,
    })
    arguments["main_memory"] = {
        'global': "%tgt",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z5kTilePKfPfjjjj")
    construct_memory_execute_mode(test_block, test_thread, 256, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_convnet_kDotProduct_r():
    test_block = Block((-1, -1, 0), (2, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (3, 3, 1))
    global_current_env = parse_function("./cuda-convnet2-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13kDotProduct_rPfS_S_j"), {
        "%numElements": 5,
    })
    arguments["main_memory"] = {
        'global': None,
        'shared': "@_ZZ13kDotProduct_rPfS_S_jE5shmem",
    }
    generate_memory_container(["%off"], global_current_env)
    target_memory = global_current_env.get_value("memory_container")
    generate_random_data_for_memory(target_memory, "%off", 100)
    raw_code = global_current_env.get_value("@_Z13kDotProduct_rPfS_S_j")
    construct_memory_execute_mode(test_block, test_thread, 256, 512, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_thundersvm_c_smo_solve_kernel():
    test_block = Block((-1, -1, 0), (1, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (34, 1, 1))
    global_current_env = parse_function("./thundersvm-new-bug/new-fun.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i"), {
        "%ws_size": 8,
        "%Cp": 1.0,
        "%Cn": 1.0,
        "%row_len": 2,
        "%eps": 1.0,
        "%max_t_iter": 3,
    })
    arguments["main_memory"] = {
        'global': "%alpha",
        'shared': "@_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem",
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i")
    construct_memory_execute_mode(test_block, test_thread, 256, 512, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_arrayfire_convolve2():
    test_block = Block((-1, -1, 0), (2, 2, 1))  # important
    test_thread = Thread((-1, -1, 0), (3, 3, 3))
    global_current_env = parse_function("./arrayfire-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z9convolve2PiS_iS_S_S_S_iiiiiiii"), {
        "%nBBS0": 8,
        "%nBBS1": 1,
        "%o2": 1,
        "%o3": 2,
        "%s2": 1,
        "%s3": 2,
        "%expand": 1,
        "%fLen0": 2,
        "%fLen1": 1,
    })
    arguments["main_memory"] = {
        'global': None,
        'shared': "@_ZZ9convolve2PiS_iS_S_S_S_iiiiiiiiE7shrdMem",
    }
    generate_memory_container(["%out_strides", "%out_dims", "%signal_strides", "%signal_dims"], global_current_env)
    target_memory = global_current_env.get_value("memory_container")
    fill_data_to_memory_by_list(target_memory, "%out_strides", [1, 1, 1])
    fill_data_to_memory_by_list(target_memory, "%out_dims", [1, 2, 3])
    fill_data_to_memory_by_list(target_memory, "%signal_strides", [1, 1, 1])
    fill_data_to_memory_by_list(target_memory, "%signal_dims", [1, 2, 3])
    raw_code = global_current_env.get_value("@_Z9convolve2PiS_iS_S_S_S_iiiiiiii")
    construct_memory_execute_mode(test_block, test_thread, 256, 512, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cuda_sift_MatchSiftPoints():
    test_block = Block((-1, -1, 0), (2, 2, 1))  # important
    test_thread = Thread((-1, -1, 0), (16, 16, 1))
    global_current_env = parse_function("./cudaSift-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z15MatchSiftPointsPfS_S_ii"), {
        "%numPts1": 1,
        "%numPts2": 2,
    })
    arguments["main_memory"] = {
        'global': "%corrData",
        'shared': "@_ZZ15MatchSiftPointsPfS_S_iiE4sums",
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z15MatchSiftPointsPfS_S_ii")
    construct_memory_execute_mode(test_block, test_thread, 256, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cuda_sift_MatchSiftPoints2():
    test_block = Block((-1, -1, 0), (2, 2, 1))  # important
    test_thread = Thread((-1, -1, 0), (16, 16, 1))
    global_current_env = parse_function("./cudaSift-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z16MatchSiftPoints2PfS_S_ii"), {
        "%numPts1": 1,
        "%numPts2": 2,
    })
    arguments["main_memory"] = {
        'global': "%corrData",
        'shared': "@_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints1",
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z16MatchSiftPoints2PfS_S_ii")
    construct_memory_execute_mode(test_block, test_thread, 256, 2048, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cuda_sift_MatchSiftPoints3():
    test_block = Block((-1, -1, 0), (1, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (2, 2, 2))
    global_current_env = parse_function("./cudaSift-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z16MatchSiftPoints3PfS_S_ii"), {
        "%numPts1": 1,
        "%numPts2": 2,
    })
    arguments["main_memory"] = {
        'global': "%corrData",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z16MatchSiftPoints3PfS_S_ii")
    construct_memory_execute_mode(test_block, test_thread, 256, 2048, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cuda_sift_MatchSiftPoints4():
    test_block = Block((-1, -1, 0), (2, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (34, 2, 1))
    global_current_env = parse_function("./cudaSift-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z16MatchSiftPoints4PfS_S_ii"), {
        "%numPts1": 1,
        "%numPts2": 2,
    })
    arguments["main_memory"] = {
        'global': "%corrData",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z16MatchSiftPoints4PfS_S_ii")
    construct_memory_execute_mode(test_block, test_thread, 256, 2048, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cuda_sift_FindMaxCorr():
    test_block = Block((-1, -1, 0), (2, 2, 1))  # important
    test_thread = Thread((-1, -1, 0), (16, 16, 1))
    global_current_env = parse_function("./cudaSift-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13FindMaxCorr_2PfS_S_iii"), {
        "%numPts1": 1,
        "%corrWidth": 2,
        "%siftSize": 3,
    })
    arguments["main_memory"] = {
        'global': "%corrData",
        'shared': "@_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex",
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z13FindMaxCorr_2PfS_S_iii")
    construct_memory_execute_mode(test_block, test_thread, 256, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cudamat_random():
    test_block = Block((-1, -1, 0), (2, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (128, 1, 1))
    global_current_env = parse_function("./cudamat-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z15kRandomGaussianPjPyPfj"), {
        "%numElements": 16,
    })
    arguments["main_memory"] = {
        'global': "%rndWords",
        'shared': None,
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z15kRandomGaussianPjPyPfj")
    construct_memory_execute_mode(test_block, test_thread, 256, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cudamat_kMinColumnwise():
    test_block = Block((-1, -1, 0), (9, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (33, 1, 1))
    global_current_env = parse_function("./cudamat-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z14kMinColumnwisePfS_jj"), {
        "%width": 9,
        "%height": 9,
    })
    arguments["main_memory"] = {
        'global': "%target",
        'shared': "@_ZZ14kMinColumnwisePfS_jjE8min_vals",
    }
    generate_memory_container(["%mat"], global_current_env)
    target_memory = global_current_env.get_value("memory_container")
    generate_random_float_data_for_memory(target_memory, "%mat", 256)
    raw_code = global_current_env.get_value("@_Z14kMinColumnwisePfS_jj")
    construct_memory_execute_mode(test_block, test_thread, 256, 32, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_cuda_cnn_g_getCost_3():
    test_block = Block((-1, -1, 0), (1, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (34, 1, 1))
    global_current_env = parse_function("./cuda-cnn-new-bug/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z11g_getCost_3PfS_fi"), {
        "%lambda": 1.0,
        "%wlen": 5,
    })
    arguments["main_memory"] = {
        'global': None,
        'shared': "@_ZZ11g_getCost_3PfS_fiE4_sum",
    }
    generate_memory_container([], global_current_env)
    raw_code = global_current_env.get_value("@_Z11g_getCost_3PfS_fi")
    construct_memory_execute_mode(test_block, test_thread, 256, 512, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, True)


def performance_sync_FindMaxCorr():
    test_block = Block((-1, -1, 0), (2, 2, 1))  # important
    test_thread = Thread((-1, -1, 0), (16, 16, 1))
    global_current_env = parse_function("./cudaSift-new-bug/new-func-performance.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z13FindMaxCorr_2PfS_S_iii"), {
        "%numPts1": 1,
        "%corrWidth": 2,
        "%siftSize": 3,
    })
    arguments["main_memory"] = {
        'global': "%corrData",
        'shared': "@_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex",
    }
    generate_memory_container([], global_current_env)

    raw_code = global_current_env.get_value("@_Z13FindMaxCorr_2PfS_S_iii")
    construct_memory_execute_mode(test_block, test_thread, 256, 256, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def performance_sync_cuda_cnn_g_getCost_3():
    test_block = Block((-1, -1, 0), (1, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (32, 1, 1))
    global_current_env = parse_function("./cuda-cnn-new-bug/new-func-performance.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z11g_getCost_3PfS_fi"), {
        "%lambda": 1.0,
        "%wlen": 5,
    })
    arguments["main_memory"] = {
        'global': None,
        'shared': "@_ZZ11g_getCost_3PfS_fiE4_sum",
    }
    generate_memory_container([], global_current_env)
    raw_code = global_current_env.get_value("@_Z11g_getCost_3PfS_fi")
    construct_memory_execute_mode(test_block, test_thread, 256, 32, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def performance_sync_cudpp_sparseMatrixVectorSetFlags():
    test_block = Block((-1, -1, 0), (1, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (32, 1, 1))
    global_current_env = parse_function("./cudpp-new-bug/new-func-performance.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z26sparseMatrixVectorSetFlagsPjPKjj"), {
        "%numRows": 5,
    })
    arguments["main_memory"] = {
        'global': "%d_rowindx",
        'shared': None,
    }
    generate_memory_container([], global_current_env)
    raw_code = global_current_env.get_value("@_Z26sparseMatrixVectorSetFlagsPjPKjj")
    construct_memory_execute_mode(test_block, test_thread, 100, 100, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_xmrig():
    test_block = Block((-1, -1, 0), (3, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (5, 1, 1))
    global_current_env = parse_function("./xmrig/new-func.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z27cryptonight_core_gpu_phase3iiiPKjPjS1_"), {
        "%threads": 25,
        "%bfactor": 6,
        "%partidx": 0,
    })
    arguments["main_memory"] = {
        'global': None,
        'shared': "@_ZZ27cryptonight_core_gpu_phase3iiiPKjPjS1_E12sharedMemory",
    }
    generate_memory_container([], global_current_env)
    raw_code = global_current_env.get_value("@_Z27cryptonight_core_gpu_phase3iiiPKjPjS1_")
    construct_memory_execute_mode(test_block, test_thread, 512, 1024, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def test_gunrock():
    test_block = Block((-1, -1, 0), (4, 1, 1))  # important
    test_thread = Thread((-1, -1, 0), (33, 1, 1))
    global_current_env = parse_function("./gunrock/gunrock.ll")
    arguments = generate_arguments(global_current_env.get_value("@_Z4JoiniiPKiS0_PiS0_S0_S0_S1_S1_"), {
        "%edges": 1,
        "%iter": 0,
    })
    arguments["main_memory"] = {
        'global': "%froms_out",
        'shared': None,
    }
    generate_memory_container(["%pos", "%intersect", ], global_current_env)
    target_memory = global_current_env.get_value("memory_container")
    fill_data_to_memory_by_list(target_memory, "%pos", [9, 10, 11])
    fill_data_to_memory_by_list(target_memory, "%intersect", [5, 11, 3])
    raw_code = global_current_env.get_value("@_Z4JoiniiPKiS0_PiS0_S0_S0_S1_S1_")
    construct_memory_execute_mode(test_block, test_thread, 512, 512, raw_code.raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_current_env, False)


def execute_framework(blocks, threads, raw_codes, arguments, global_env, main_size=512, shared_size=512,
                      should_print=False):
    print "===================================================================================="
    print "Test on " + str(arguments)
    print_arguments(arguments)
    print "Dimension: " + str(blocks.grid_dim) + " " + str(threads.block_dim)
    construct_memory_execute_mode(blocks, threads, main_size, shared_size, raw_codes, arguments,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_env, should_print)
    print "===================================================================================="


def execute_framework_advanced(blocks, threads, raw_codes, arguments, global_env, main_size=512, shared_size=512,
                      should_print=False):
    print "===================================================================================="
    print "Test on " + str(arguments)
    print_arguments(arguments)
    print "Dimension: " + str(blocks.grid_dim) + " " + str(threads.block_dim)
    construct_memory_execute_mode_for_barrier(blocks, threads, main_size, shared_size, raw_codes, arguments,
                                              parse_target_memory_and_checking_sync,
                                              parse_target_memory_and_checking_sync, global_env, should_print)
    print "===================================================================================="


def print_arguments(arguments):
    for key in arguments:
        current_item = arguments[key]
        show_item = current_item
        if isinstance(current_item, DataType):
            show_item = current_item.value
        print key, show_item


if __name__ == "__main__":
    # global_test_env = parse_function("./kaldi-new-bug/new-func.ll")
    # test_copy_low_upp()
    test_copy_upp_low()
    # test_add_diag_vec_mat()
    # test_copy_from_tp()
    # test_copy_from_mat()
    # test_trace_mat_mat_trans()
    # test_slice()
    # test_convnet_kReflectH()
    # test_convnet_kTile()
    # test_convnet_kDotProduct_r()
    # test_thundersvm_c_smo_solve_kernel()
    # test_arrayfire_convolve2()
    # test_cuda_sift_MatchSiftPoints4()
    # test_cuda_sift_FindMaxCorr()
    # test_cudamat_random()
    # test_cudamat_kMinColumnwise()
    # test_cuda_cnn_g_getCost_3()
    # performance_sync_FindMaxCorr()
    # performance_sync_cuda_cnn_g_getCost_3()
    # performance_sync_cudpp_sparseMatrixVectorSetFlags()
    # test_xmrig()
    # test_gunrock()
    print 'over'

