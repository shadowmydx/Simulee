from DataStructure import *
from StatementExecutor import *


def generator_for_dimension_var(target):
    for target_index_x in xrange(target.limit_x):
        for target_index_y in xrange(target.limit_y):
            for target_index_z in xrange(target.limit_z):
                yield target_index_x, target_index_y, target_index_z


def is_all_thread_finished(thread_dict):
    for key in thread_dict:
        if thread_dict[key] is True:
            return False
    return True


def construct_memory_execute_mode(blocks, threads, global_size, shared_size, raw_kernel_codes, arguments,
                                  shared_parser, global_parser, global_env=None):
    main_memory = arguments['main_memory']
    global_memory = GlobalMemory(global_size)
    if global_env is None:
        global_env = Environment()
    for block_indexes in generator_for_dimension_var(blocks):
        global_env.add_value("@blockIdx", Block(block_indexes, (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        global_env.add_value("@gridDim", Block((blocks.limit_x, blocks.limit_y, blocks.limit_z),
                                               (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        shared_memory = SharedMemory(shared_size)
        visit_order_for_global_memory = [0 for i in xrange(global_size)]
        visit_order_for_shared_memory = [0 for i in xrange(shared_size)]
        current_visited_global_memory_index = StackSet()
        current_visited_shared_memory_index = StackSet()
        local_env_dict = dict()
        unfinished_total_threads = dict()
        for thread_indexes in generator_for_dimension_var(threads):
            unfinished_total_threads[str(thread_indexes)] = True
        synchronization = SyncThreads(len(unfinished_total_threads), unfinished_total_threads)
        while not is_all_thread_finished(unfinished_total_threads):
            for thread_indexes in generator_for_dimension_var(threads):
                global_env.add_value("@threadIdx", Thread(thread_indexes,
                                                          (threads.limit_x, threads.limit_y, threads.limit_z)))
                global_env.add_value("@blockDim", Thread((threads.limit_x, threads.limit_y, threads.limit_z),
                                                         (threads.limit_x, threads.limit_y, threads.limit_z)))
                if str(thread_indexes) not in local_env_dict:
                    local_env_dict[str(thread_indexes)] = Environment()
                    local_env_dict[str(thread_indexes)].binding_value(arguments)
                    local_env_dict[str(thread_indexes)].add_value('kernel_code', KernelCodes(raw_kernel_codes))
                local_env = local_env_dict[str(thread_indexes)]
                kernel_codes = local_env.get_value('kernel_code')
                current_line = kernel_codes.get_current_line()
                if kernel_codes.is_over():
                    unfinished_total_threads[str(thread_indexes)] = False
                    continue
                if kernel_codes.should_halt():
                    print "halt here because of __syncthreads() " + " in " + str(thread_indexes) + " in block " \
                          + str(block_indexes)
                    continue
                current_stmt = kernel_codes.get_current_statement_and_set_next()
                print 'execute ' + current_stmt + " in " + str(thread_indexes) + " in block " + str(block_indexes)
                if detect_if_is_syncthreads(current_stmt):
                    synchronization.reach_one(thread_indexes, kernel_codes)
                    if synchronization.can_continue():
                        while current_visited_global_memory_index.size() != 0:
                            visit_order_for_global_memory[current_visited_global_memory_index.pop()] += 1
                        while current_visited_shared_memory_index.size() != 0:
                            visit_order_for_shared_memory[current_visited_shared_memory_index.pop()] += 1
                else:
                    return_value, current_action, current_index, is_global = \
                        execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env)
                    if current_action is None:
                        continue
                    saved_action = Action((current_stmt, current_line, current_action, block_indexes, thread_indexes))
                    if is_global:
                        global_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_global_memory[current_index])
                        current_visited_global_memory_index.push(current_index)
                    else:
                        shared_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_shared_memory[current_index])
                        current_visited_shared_memory_index.push(current_index)
        shared_parser(shared_memory)
    global_parser(global_memory)


def get_key_from_action(single_action):
    return str(single_action.block) + " " + str(single_action.thread)


def show_dict(target_dict):
    for key in target_dict:
        print key + ":  " + target_dict[key]


def has_not_equal_key(dict_one, dict_two):
    result = False
    for key in dict_one:
        if key not in dict_two:
            return True
    return result


def parse_target_memory_and_checking_sync(target_memory):
    memory_lst = target_memory.list
    for single_index in xrange(len(memory_lst)):
        single_memory_item = memory_lst[single_index]
        visit_lst = single_memory_item.visit_lst
        for single_visit_order in visit_lst:
            visit_read_dict = dict()
            visit_write_dict = dict()
            has_write = False
            for single_action in single_visit_order:
                if single_action.action == 'write':
                    has_write = True
                    visit_write_dict[get_key_from_action(single_action)] = single_action.current_stmt
                if single_action.action == 'read':
                    visit_read_dict[get_key_from_action(single_action)] = single_action.current_stmt
            if has_write:
                if len(visit_write_dict) >= 2:
                    print 'detect w&w synchronisation issue'
                    print 'write:'
                    show_dict(visit_write_dict)
                if len(visit_read_dict) >= 1 and len(visit_write_dict) >= 1 and \
                        has_not_equal_key(visit_read_dict, visit_write_dict):
                    print 'detect r&w synchronisation issue'
                    print 'read:'
                    show_dict(visit_read_dict)
                    print 'write:'
                    show_dict(visit_write_dict)


if __name__ == "__main__":
    # test_block = Block((-1, -1, 0), (2, 2, 1))
    # test_thread = Thread((-1, -1, 0), (2, 2, 1))
    # args = {
    #     "%A": DataType("float*"),
    #     "%B": DataType("float*"),
    #     "%value": DataType("float*"),
    #     "%dim": DataType("i32"),
    #     "main_memory": "%A"
    # }
    # args['%A'].set_value("%A")
    # args['%B'].set_value("%B")
    # args['%value'].set_value("%value")
    # test_global_size = 256
    # test_shared_size = 256
    # codes = open('./codes.ll', 'r').read()
    test_block = Block((-1, -1, 0), (2, 1, 1))
    # test_thread = Thread((-1, -1, 0), (10, 1, 1))
    test_thread = Thread((-1, -1, 0), (128, 1, 1))
    num_elements = DataType('i32')
    num_elements.set_value(100)
    # num_elements.set_value(2)
    # args = {
    #     "%input_array": DataType("i32*"),
    #     "%num_elements": num_elements,
    #     "main_memory": "%input_array"
    # }
    # args['%input_array'].set_value("%input_array")
    args = {
        "%x": DataType("i32*"),
        "%dim": num_elements,
        "main_memory": "%x"
    }
    args["%x"].set_value("%x")
    test_global_size = 100
    test_shared_size = 256
    codes = open('./test2.ll', 'r').read()
    construct_memory_execute_mode(test_block, test_thread, test_global_size, test_shared_size, codes, args, lambda x:x, None)
