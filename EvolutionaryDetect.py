from Evolution import auto_test_target_function
from Evolution import auto_test_target_function_advanced


def test_device_global():
    auto_test_target_function("./read_write_test.ll", "@_Z13device_globalPji", {
        "global": "%input_array",
        "shared": None
    })


def test_sum_reduced():
    auto_test_target_function_advanced("./kaldi-new-bug/fse-func.ll", "@_Z11_sum_reducePd", {
        "global": "%buffer",
        "shared": None
    })  # race & unnecessary


def test_copy_low_upp():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_low_uppPfii", {
        "global": "%A",
        "shared": None
    })


def test_copy_upp_low():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_upp_lowPfii", {
        "global": "%A",
        "shared": None
    })


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


def test_copy_from_mat():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z14_copy_from_matPfPKfiiii", {
        "global": "%mat_out",
        "shared": None
    })


def test_splice():
    auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z7_splicePfPKfPKiiiiiii", {
        "global": "%y",
        "shared": None
    })


def test_thundersvm_c_smo_solve_kernel():
    auto_test_target_function("./thundersvm-new-bug/new-fun.ll", "@_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i", {
        "global": "%alpha",
        "shared": "@_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem"
    }, used_default_dimension=True)


def test_gunrock_join():
    auto_test_target_function("./gunrock/fse-func.ll", "@_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_", {
        "global": "%froms_out",
        "shared": None
    }, fixed_dimension=[(2, 1, 1), (33, 1, 1)], used_default_dimension=True)


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


if __name__ == "__main__":
    test_gunrock_join()
    # test_sum_reduced()
    # test_sync_cudpp_sparseMatrixVectorSetFlags()
    # test_sync_FindMaxCorr()
    # test_sync_cuda_cnn_g_getCost_3()
    # test_splice()
