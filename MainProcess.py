from DataStructure import *
from StatementExecutor import *


def generator_for_dimension_var(target):
    for target_index_x in xrange(target.limit_x):
        for target_index_y in xrange(target.limit_y):
            for target_index_z in xrange(target.limit_z):
                yield target_index_x, target_index_y, target_index_z


def construct_memory_execute_mode(blocks, threads, global_size, shared_size, kernel_codes, arguments,
                                  shared_parser, global_parser, global_env=None):
    main_memory = arguments['main_memory']
    global_memory = GlobalMemory(global_size)
    if global_env is None:
        global_env = Environment()
    kernel_codes = KernelCodes(kernel_codes)
    for block_indexes in generator_for_dimension_var(blocks):
        global_env.add_value("@blockIdx", Block(block_indexes, (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        shared_memory = SharedMemory(shared_size)
        visit_order_for_global_memory = [0 for i in xrange(global_size)]
        visit_order_for_shared_memory = [0 for i in xrange(shared_size)]
        current_visited_global_memory_index = StackSet()
        current_visited_shared_memory_index = StackSet()
        while not kernel_codes.is_over():
            for thread_indexes in generator_for_dimension_var(threads):
                global_env.add_value("@threadIdx", Thread(thread_indexes,
                                                          (threads.limit_x, threads.limit_y, threads.limit_z)))
                local_env = Environment()
                local_env.binding_value(arguments)
                if detect_if_is_syncthreads(kernel_codes):
                    while current_visited_global_memory_index.size() != 0:
                        visit_order_for_global_memory[current_visited_global_memory_index.pop()] += 1
                    while current_visited_shared_memory_index.size() != 0:
                        visit_order_for_shared_memory[current_visited_shared_memory_index.pop()] += 1
                else:
                    current_action, current_index, is_global = \
                        execute_statement_and_get_action(kernel_codes, main_memory, global_env, local_env)
                    if current_action is None:
                        continue
                    if is_global:
                        global_memory.list[current_index].set_by_order(current_action,
                                                                       visit_order_for_global_memory[current_index])
                        current_visited_global_memory_index.push(current_index)
                    else:
                        shared_memory.list[current_index].set_by_order(current_action,
                                                                       visit_order_for_shared_memory[current_index])
                        current_visited_shared_memory_index.push(current_index)
            shared_parser(shared_memory)
    global_parser(global_memory)


if __name__ == "__main__":
    test_block = Block((-1, -1, 0), (2, 2, 1))
    test_thread = Thread((-1, -1, 0), (2, 2, 1))
    args = {
        "%A": DataType("float*"),
        "%B": DataType("float*"),
        "%value": DataType("float*"),
        "%dim": DataType("i32"),
        "main_memory": "%A"
    }
    args['%A'].set_value("%A")
    args['%B'].set_value("%B")
    args['%value'].set_value("%value")
    test_global_size = 256
    test_shared_size = 256
    codes = open('./codes.ll', 'r').read()
    construct_memory_execute_mode(test_block, test_thread, test_global_size, test_shared_size, codes, args, None, None)
