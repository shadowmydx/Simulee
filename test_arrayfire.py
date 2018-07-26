from DataStructure import *
from MainProcess import construct_memory_execute_mode
from MainProcess import parse_target_memory_and_checking_sync


# i32* %idx_ptr, i32* %dist_ptr, i32* %in_idx, i32* %in_dist, i32 %nfeat, i32 %nelem, i32 %max_dist
# fix syncthreads in cuda nearest neighbour
def test_barrier_fix_syncthreads():
    test_block = Block((-1, -1, 0), (2, 1, 1))
    test_thread = Thread((-1, -1, 0), (2, 3, 1))
    global_env_test = Environment()
    shared_memory_test_1 = DataType("[256 x i32]*")
    shared_memory_test_1.set_value("@_ZZ14select_matchesPjPiPKjPKijjiE6s_dist")
    shared_memory_test_2 = DataType("[256 x i32]*")
    shared_memory_test_2.set_value("@_ZZ14select_matchesPjPiPKjPKijjiE5s_idx")
    global_env_test.add_value("@_ZZ14select_matchesPjPiPKjPKijjiE6s_dist", shared_memory_test_1)
    global_env_test.add_value("@_ZZ14select_matchesPjPiPKjPKijjiE5s_idx", shared_memory_test_2)
    memory_container = MemoryContainer()
    memory_container.add_new_memory("@_ZZ14select_matchesPjPiPKjPKijjiE5s_idx")
    memory_container.add_new_memory("@_ZZ14select_matchesPjPiPKjPKijjiE6s_dist")
    global_env_test.add_value("memory_container", memory_container)
    num_elements = DataType('i32')
    num_elements.set_value(2)
    max_dist = DataType('i32')
    max_dist.set_value(5)
    n_feat = DataType('i32')
    n_feat.set_value(5)
    args = {
        "%idx_ptr": DataType("i32*"),
        "%dist_ptr": DataType("i32*"),
        "%in_idx": DataType("i32*"),
        "%in_dist": DataType("i32*"),
        "%nfeat": n_feat,
        "%nelem": num_elements,
        "%max_dist": max_dist,
        "main_memory": "NONE"
    }
    args["%idx_ptr"].set_value("%idx_ptr")
    args["%dist_ptr"].set_value("%dist_ptr")
    args["%in_idx"].set_value("%in_idx")
    args["%in_dist"].set_value("%in_dist")
    Function.read_function_from_file("./arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.ll", global_env_test)
    raw_code = global_env_test.get_value("@_Z14select_matchesPjPiPKjPKijji")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, args,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  global_env_test)


if __name__ == '__main__':
    test_barrier_fix_syncthreads()
