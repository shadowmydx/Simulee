from Evolution import auto_test_target_function
from Evolution import auto_test_target_function_advanced
from Evolution import auto_test_target_function_dynamical
from DetectBug import generate_random_data_for_memory
from DetectBug import generate_memory_container


def test_device_global():
    auto_test_target_function("./read_write_test.ll", "@_Z13device_globalPji", {
        "global": "%input_array",
        "shared": None
    })
    # }, fixed_dimension=[(1, 1, 1), (5, 1, 1)], used_default_dimension=True)


def test_colonel():
    auto_test_target_function("./conel.ll", "@_Z7colonelPi", {
        "global": "%in",
        "shared": None
    # })
    }, fixed_dimension=[(1, 1, 1), (52, 1, 1)], used_default_dimension=True)


def test_device_global_repaired():
    auto_test_target_function("./read_write_test_repaired.ll", "@_Z13device_globalPji", {
        "global": "%input_array",
        "shared": None
    }, fixed_dimension=[(1, 1, 1), (5, 1, 1)], used_default_dimension=True)
    # })


def test_sum_reduced():
    auto_test_target_function_advanced("./kaldi-new-bug/fse-func.ll", "@_Z11_sum_reducePd", {
        "global": "%buffer",
        "shared": None
    })
    # }, fixed_dimension=[(3, 1, 1), (2, 1, 1)], used_default_dimension=True)  # race & unnecessary


def test_copy_low_upp():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_low_uppPfii", {
        "global": "%A",
        "shared": None
    })
    # }, fixed_dimension=[(1, 1, 1), (3, 1, 1)], used_default_dimension=True)


def test_copy_upp_low():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_upp_lowPfii", {
        "global": "%A",
        "shared": None
    })
    # }, fixed_dimension=[(1, 1, 1), (4, 1, 1)], used_default_dimension=True)


def test_add_diag_vec_mat():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z17_add_diag_vec_matfPfiiiPKfS1_iif", {
        "global": "%mat",
        "shared": None
    })


def test_copy_from_tp():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_from_tpPfPKfiii", {
        "global": "%A",
        "shared": None
    })
    # }, fixed_dimension=[(1, 1, 1), (5, 1, 1)], used_default_dimension=True)


def test_copy_from_mat():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z14_copy_from_matPfPKfiiii", {
        "global": "%mat_out",
        "shared": None
    })
    # }, fixed_dimension=[(1, 1, 1), (5, 1, 1)], used_default_dimension=True)


def test_splice():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z7_splicePfPKfPKiiiiiii", {
        "global": "%y",
        "shared": None
    })


def test_trace_mat_mat():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z20_trace_mat_mat_transPKfS0_iiiiPf", {
        "global": None,
        "shared": "@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"
    })


def test_thundersvm_c_smo_solve_kernel():
    auto_test_target_function("./thundersvm-new-bug/new-fun.ll", "@_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i", {
        "global": "%alpha",
        "shared": "@_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem"
    }, used_default_dimension=True)


def test_thundersvm_nu_smo_solve_kernel():
    auto_test_target_function("./thundersvm-repair/smo_kernel.ll", "@_Z19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_", {
        "global": None,
        "shared": "@_ZZ19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_E10shared_mem"
    }, used_default_dimension=True)


def test_gunrock_join():
    auto_test_target_function("./gunrock/new-func2.ll", "@_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_", {
        "global": "%froms_out",
        "shared": None
    # })
    }, fixed_dimension=[(4, 1, 1), (33, 1, 1)], used_default_dimension=True)


def test_gunrock_collect():
    auto_test_target_function_advanced("./gunrock/gunrock1.ll", "@_Z7CollectiiPKiS0_S0_PiS1_S1_S1_", {
        "global": "%froms",
        "shared": None
    })
    # }, fixed_dimension=[(4, 1, 1), (33, 1, 1)], used_default_dimension=True)


def test_gunrock_join2():
    auto_test_target_function("./gunrock/new-func2.ll", "@_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_", {
        "global": "%froms_out",
        "shared": None
    })


def test_gunrock_xmrig():
    auto_test_target_function_advanced("./xmrig/new-func.ll", "@_Z27cryptonight_core_gpu_phase3iiiPKjPjS1_", {
        'global': None,
        'shared': "@_ZZ27cryptonight_core_gpu_phase3iiiPKjPjS1_E12sharedMemory",
    })


def test_arrayfire_compute_median():
    auto_test_target_function_advanced("./arrayfire-repair/computeMedian.ll", "@_Z13computeMedianj", {
        'global': None,
        'shared': "@_ZZ13computeMedianjE5s_idx",
    })


def test_arrayfire_harris_response():
    auto_test_target_function_advanced("./arrayfire-repair/harris_response.ll", "@_Z15harris_responsePfS_PKfS1_S1_jS_jfj", {
        'global': "%image_ptr",
        'shared': None,
    })


def test_convnet2_kTile():
    auto_test_target_function("./cuda-convnet2-new-bug/new-func.ll", "@_Z5kTilePKfPfjjjj", {
        "global": "%tgt",
        "shared": None
    }, fixed_dimension=[(2, 2, 1), (3, 1, 1)], used_default_dimension=True)


def test_convenet2_kDotProduct():
    auto_test_target_function("./cuda-convnet2-new-bug/new-func.ll", "@_Z13kDotProduct_rPfS_S_j", {
        "global": None,
        "shared": "@_ZZ13kDotProduct_rPfS_S_jE5shmem"
    }, fixed_dimension=[(2, 1, 1), (3, 3, 1)], used_default_dimension=True)


def test_sync_cuda_cnn_g_getCost_3():
    auto_test_target_function_advanced("./cuda-cnn-new-bug/new-func.ll", "@_Z11g_getCost_3PfS_fi", {
        "global": None,
        "shared": "@_ZZ11g_getCost_3PfS_fiE4_sum"
    })


def test_sync_FindMaxCorr():
    auto_test_target_function_advanced("./cudaSift-new-bug/new-func.ll", "@_Z11FindMaxCorrPfS_S_iii", {
        "global": "%sift1",
        "shared": None
    })


def test_sync_cudpp_sparseMatrixVectorSetFlags():
    auto_test_target_function_advanced("./cudpp-new-bug/new-func.ll", "@_Z26sparseMatrixVectorSetFlagsPjPKjj", {
        "global": "%d_flags",
        "shared": None
    })


def test_kaldi_add_diag():
    auto_test_target_function("./kaldi-repair/_add_diag_mat.ll", "@_Z17_add_diag_mat_matdPdiPKdiiiS1_iid", {
        "global": None,
        "shared": "@_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data"
    }, fixed_dimension=[(1, 1, 1), (128, 1, 1)], used_default_dimension=True)


def test_arrayfire_scan_dim():
    auto_test_target_function_dynamical("./arrayfire-repair/scan_dim.ll", "@_Z15scan_dim_kerneljjjj", {
        "global": None,
        "shared": "@_ZZ15scan_dim_kerneljjjjE5s_tmp"
    })
    # }, fixed_dimension=[(2, 1, 1), (5, 5, 1)], used_default_dimension=True)


def test_arrayfire_scan_dim_nofinal_kernel():
    auto_test_target_function_dynamical("./arrayfire-repair/scan_dim_by_key_impl.ll", "@_Z24scan_dim_nonfinal_kerneljjj", {
        "global": None,
        "shared": "@_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp"
    })
    # }, fixed_dimension=[(1, 1, 1), (5, 5, 1)], used_default_dimension=True)


def test_arrayfire_scan_nofinal_kernel():
    auto_test_target_function_dynamical("./arrayfire-repair/scan_first_by_key_impl.ll", "@_Z20scan_nonfinal_kerneljjj", {
        "global": None,
        "shared": "@_ZZ20scan_nonfinal_kerneljjjE6s_ftmp"
    }, fixed_dimension=[(1, 1, 1), (5, 5, 1)], used_default_dimension=True)


def test_arrayfire_reduce():
    auto_test_target_function_dynamical("./arrayfire-repair/reducebd.ll", "@_Z11warp_reducePd", {
        "global": "%s_ptr",
        "shared": None
    }, fixed_dimension=[(1, 1, 1), (34, 1, 1)], used_default_dimension=True)


def test_arrayfire_compute_val_homography():
    auto_test_target_function_dynamical("./arrayfire-repair/homography.ll", "@_Z21computeEvalHomographyjjjf", {
        "global": None,
        "shared": "@_ZZ21computeEvalHomographyjjjfE5s_idx"
    }, fixed_dimension=[(1, 1, 1), (128, 1, 1)], used_default_dimension=True)


def test_arrayfire_hamming_matcher_unroll_1():
    auto_test_target_function_dynamical("./arrayfire-repair/hamming1.ll", "@_Z22hamming_matcher_unrollPjS_j", {
        "global": None,
        "shared": "@_ZZ22hamming_matcher_unrollPjS_jE6s_dist"
    }, fixed_dimension=[(1, 1, 1), (36, 1, 1)], used_default_dimension=True)


def test_arrayfire_hamming_matcher_unroll_2():
    auto_test_target_function_dynamical("./arrayfire-repair/hamming5.ll", "@_Z22hamming_matcher_unrollPjS_jj", {
        "global": "%out_idx",
        "shared": None
    }, fixed_dimension=[(1, 1, 1), (36, 1, 1)], used_default_dimension=True)


def test_arrayfire_hamming_matcher_1():
    auto_test_target_function_dynamical("./arrayfire-repair/hamming2.ll", "@_Z15hamming_matcherPjS_jj", {
        "global": None,
        "shared": "@_ZZ15hamming_matcherPjS_jjE6s_dist"
    # })
    }, fixed_dimension=[(1, 1, 1), (36, 1, 1)], used_default_dimension=True)


def test_arrayfire_hamming_matcher_2():
    auto_test_target_function_dynamical("./arrayfire-repair/hamming3.ll", "@_Z15hamming_matcherPjS_jj", {
        "global": None,
        "shared": "@_ZZ15hamming_matcherPjS_jjE6s_dist"
    })
    # }, fixed_dimension=[(1, 1, 1), (36, 1, 1)], used_default_dimension=True, initial_function=dummy_data_for_shared_memory_hamming3)


def test_arrayfire_JacobiSVD():
    auto_test_target_function_dynamical("./arrayfire-repair/JacobiSVD.ll", "@_Z9JacobiSVDPiS_ii", {
        "global": None,
        "shared": "@_ZZ9JacobiSVDPiS_iiE3s_S"
    })
    # }, fixed_dimension=[(1, 1, 1), (3, 3, 1)], used_default_dimension=True)


def test_arrayfire_reduce1():
    auto_test_target_function_dynamical("./arrayfire-repair/reduce.ll", "@_Z11warp_reducePiPj", {
        "global": "%s_ptr",
        "shared": None
    }, fixed_dimension=[(1, 1, 1), (34, 1, 1)], used_default_dimension=True)


def test_arrayfire_select_matches():
    auto_test_target_function_dynamical("./arrayfire-repair/select_matches.ll", "@_Z14select_matchesPKjPKijji", {
        "global": "%in_idx",
        "shared": None
    })


def test_arrayfire_descriptor():
    auto_test_target_function_dynamical("./arrayfire-repair/Descriptor1.ll", "@_Z17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffi", {
        "global": None,
        "shared": "@_ZZ17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffiE7shrdMem"
    # })
    }, fixed_dimension=[(1, 1, 1), (3, 10, 1)], used_default_dimension=True)


def test_gklee_test_barrier1():
    auto_test_target_function_dynamical("./gklee-test-repair/barrier1.ll", "@_Z2dlPi", {
        "global": "%in",
        "shared": None,
    }, fixed_dimension=[(1, 1, 1), (32, 1, 1)], used_default_dimension=True)


def test_gklee_test_barrier3():
    auto_test_target_function_dynamical("./gklee-test-repair/barrier3.ll", "@_Z2dlPi", {
        "global": "%in",
        "shared": None,
    }, fixed_dimension=[(1, 1, 1), (64, 1, 1)], used_default_dimension=True)


def dummy_data_for_shared_memory_hamming3(global_env):
    generate_memory_container(["@_ZZ15hamming_matcherPjS_jjE6s_dist"], global_env)
    shared_memory = global_env.get_value("memory_container")
    generate_random_data_for_memory(shared_memory, "@_ZZ15hamming_matcherPjS_jjE6s_dist", 100)
    return global_env


if __name__ == "__main__":
    # test_convnet2_kTile()
    # test_add_diag_vec_mat() # need evolution
    # test_arrayfire_select_matches()
    # test_copy_low_upp()
    # test_copy_upp_low()
    # test_copy_from_tp()  # need evolution
    # test_copy_from_mat() # need evolution
    # test_colonel()
    # test_device_global()
    # test_trace_mat_mat()
    # test_arrayfire_harris_response()
    # test_arrayfire_compute_median()
    # test_arrayfire_hamming_matcher_2()
    # test_arrayfire_descriptor()  #
    # test_arrayfire_reduce1()  # recompile barrier divergence version
    # test_arrayfire_JacobiSVD()
    # test_arrayfire_hamming_matcher_unroll_2()
    # test_arrayfire_hamming_matcher_1()
    # test_arrayfire_hamming_matcher_unroll_1()
    # test_arrayfire_scan_nofinal_kernel()
    # test_arrayfire_scan_dim_nofinal_kernel()
    # test_gklee_test_barrier3()
    # test_gklee_test_barrier1()
    # test_arrayfire_compute_val_homography()
    # test_arrayfire_scan_dim()
    # test_kaldi_add_diag()
    # test_thundersvm_nu_smo_solve_kernel()
    # test_thundersvm_c_smo_solve_kernel()
    # test_arrayfire_reduce()
    # test_device_global_repaired()
    # test_device_global()
    # test_gunrock_xmrig()
    # test_gunrock_join2()
    # test_gunrock_collect()
    # test_gunrock_join()
    test_sum_reduced()
    # test_sync_cudpp_sparseMatrixVectorSetFlags()
    # test_sync_FindMaxCorr()
    # test_sync_cuda_cnn_g_getCost_3()
    # test_splice()
