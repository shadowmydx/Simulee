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


def print_stmt(target_stmt, should_print=True):
    if should_print:
        print target_stmt


def construct_memory_execute_mode(blocks, threads, global_size, shared_size, raw_kernel_codes, arguments,
                                  shared_parser, global_parser, global_env=None, should_print=True):
    main_memory = arguments['main_memory']
    global_memory = GlobalMemory(global_size)
    warp_size = DataType("i32")
    warp_size.set_value(32)
    if global_env is None:
        global_env = Environment()
    global_env.add_value("@warpSize", warp_size)
    global_env.add_value("main_entrance", raw_kernel_codes)
    program_flow = ProgramFlow("main_entrance", global_env, "", lambda x: x)
    program_flow.generate_all_stmt_path()
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
                    if synchronization.has_halt_threads():
                        print "Has barrier divergence issue in " + str(synchronization.get_a_hold_stmt())
                        return
                    continue
                if kernel_codes.should_halt():
                    print_stmt("halt here because of __syncthreads() " + " in " + str(thread_indexes) + " in block " +
                               str(block_indexes), should_print)
                    continue
                current_stmt = kernel_codes.get_current_statement_and_set_next()
                local_env.add_value("current_stmt", current_stmt)
                print_stmt('execute ' + current_stmt + " in " + str(thread_indexes) + " in block " + str(block_indexes),
                           should_print)
                if detect_if_is_syncthreads(current_stmt):
                    synchronization.reach_one(thread_indexes, kernel_codes)
                    if synchronization.can_continue():
                        print 'last thread located here: ' + str(thread_indexes) + ", in block " + str(block_indexes)
                        while current_visited_global_memory_index.size() != 0:
                            visit_order_for_global_memory[current_visited_global_memory_index.pop()] += 1
                        while current_visited_shared_memory_index.size() != 0:
                            visit_order_for_shared_memory[current_visited_shared_memory_index.pop()] += 1
                else:
                    return_value, current_action, current_index, is_global = \
                        execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env)
                    if current_action is None:
                        continue
                    branch_marking_function = kernel_codes.get_token_string()
                    if branch_marking_function is None:
                        saved_action = Action((current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                               (threads.limit_x, threads.limit_y, threads.limit_z)))
                    else:
                        saved_action = Action((branch_marking_function + "::" + current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                               (threads.limit_x, threads.limit_y, threads.limit_z)))
                    if is_global:
                        if current_index >= len(global_memory.list):
                            # print "There is outraged here! plz noted."
                            continue
                        global_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_global_memory[current_index])
                        current_visited_global_memory_index.push(current_index)
                    else:
                        if current_index >= len(global_memory.list):
                            # print "There is outraged here! plz noted."
                            continue
                        shared_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_shared_memory[current_index])
                        current_visited_shared_memory_index.push(current_index)
        shared_parser(shared_memory, program_flow)
    global_parser(global_memory, program_flow)


def construct_memory_execute_mode_for_barrier(blocks, threads, global_size, shared_size, raw_kernel_codes, arguments,
                                  shared_parser, global_parser, global_env=None, should_print=True):
    main_memory = arguments['main_memory']
    global_memory = GlobalMemory(global_size)
    redundant_barrier = list()
    warp_size = DataType("i32")
    warp_size.set_value(32)
    if global_env is None:
        global_env = Environment()
    global_env.add_value("@warpSize", warp_size)
    global_env.add_value("main_entrance", raw_kernel_codes)
    program_flow = ProgramFlow("main_entrance", global_env, "", lambda x: x)
    program_flow.generate_all_stmt_path()
    for block_indexes in generator_for_dimension_var(blocks):

        global_env.add_value("@blockIdx", Block(block_indexes, (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        global_env.add_value("@gridDim", Block((blocks.limit_x, blocks.limit_y, blocks.limit_z),
                                               (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
        shared_memory = SharedMemory(shared_size)
        visit_order_for_global_memory = [0 for i in xrange(global_size)]
        visit_order_for_shared_memory = [0 for i in xrange(shared_size)]
        current_visited_global_memory_index = StackSet()
        current_visited_shared_memory_index = StackSet()
        # struct for collecting data for barrier function
        shared_barr = BarrierStackSet()
        global_barr = BarrierStackSet()
        shared_mem = MemDict()
        global_mem = MemDict()
        shared_flag = dict()
        global_flag = dict()
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
                    if synchronization.has_halt_threads():
                        print "Has barrier divergence issue in " + str(synchronization.get_a_hold_stmt())
                        return
                    continue
                if kernel_codes.should_halt():
                    print_stmt("halt here because of __syncthreads() " + " in " + str(thread_indexes) + " in block " +
                               str(block_indexes), should_print)
                    continue
                current_stmt = kernel_codes.get_current_statement_and_set_next()
                local_env.add_value("current_stmt", current_stmt)
                print_stmt('execute ' + current_stmt + " in " + str(thread_indexes) + " in block " + str(block_indexes),
                           should_print)
                if detect_if_is_syncthreads(current_stmt):
                    synchronization.reach_one(thread_indexes, kernel_codes)
                    if synchronization.can_continue():
                        print 'last thread located here: ' + str(thread_indexes) + ", in block " + str(block_indexes)
                        if shared_flag.get(current_stmt) is None:
                            shared_flag[current_stmt] = True
                        if global_flag.get(current_stmt) is None:
                            global_flag[current_stmt] = True
                        while current_visited_global_memory_index.size() != 0:
                            global_index = current_visited_global_memory_index.pop()
                            global_mem.push(global_index, visit_order_for_global_memory[global_index])
                            global_barr.push(current_stmt, global_index, visit_order_for_global_memory[global_index])
                            visit_order_for_global_memory[global_index] += 1
                        global_mem.set_flag()
                        while current_visited_shared_memory_index.size() != 0:
                            shared_index = current_visited_shared_memory_index.pop()
                            shared_mem.push(shared_index, visit_order_for_shared_memory[shared_index])
                            shared_barr.push(current_stmt, shared_index, visit_order_for_shared_memory[shared_index])
                            visit_order_for_shared_memory[shared_index] += 1
                        shared_mem.set_flag()
                else:
                    return_value, current_action, current_index, is_global = \
                        execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env)
                    if current_action is None:
                        continue
                    branch_marking_function = kernel_codes.get_token_string()
                    if branch_marking_function is None:
                        saved_action = Action((current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                               (threads.limit_x, threads.limit_y, threads.limit_z)))
                    else:
                        saved_action = Action((branch_marking_function + "::" + current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                               (threads.limit_x, threads.limit_y, threads.limit_z)))
                    if is_global:
                        if current_index >= len(global_memory.list):
                            # print "There is outraged here! plz noted."
                            continue
                        global_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_global_memory[current_index])
                        current_visited_global_memory_index.push(current_index)
                    else:
                        if current_index >= len(shared_memory.list):
                            # print "There is outraged here! plz noted."
                            continue
                        shared_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_shared_memory[current_index])
                        current_visited_shared_memory_index.push(current_index)
        shared_parser(shared_memory, program_flow)
        has_no_necessarily(shared_barr, shared_memory, shared_mem, program_flow, shared_flag)
        shared_barr.clear()
        shared_mem.clear()
    global_parser(global_memory, program_flow)
    has_no_necessarily(global_barr, global_memory, global_mem, program_flow, global_flag)
    global_barr.clear()
    global_mem.clear()
    for barr in shared_flag:
        if barr in global_flag and (shared_flag[barr] and global_flag[barr]):
            redundant_barrier.append(barr)
        elif barr not in global_flag and shared_flag[barr]:
            redundant_barrier.append(barr)
    for barr in global_flag:
        if barr not in shared_flag and global_flag[barr]:
            redundant_barrier.append(barr)
    for barr in redundant_barrier:
        print '-------------------------------------------------------------------------------'
        print 'the barrier ' + barr + ' is not necessary.'
        print '-------------------------------------------------------------------------------'


#add new functions to dynamically collect information for branch divergence
def construct_memory_execute_mode_dynamically(blocks, threads, global_size, shared_size, raw_kernel_codes, arguments,
                                  shared_parser, global_parser, global_env=None, should_print=True):
    main_memory = arguments['main_memory']
    global_memory = GlobalMemory(global_size)
    warp_size = DataType("i32")
    warp_size.set_value(32)
    if global_env is None:
        global_env = Environment()
    global_env.add_value("@warpSize", warp_size)
    global_env.add_value("main_entrance", raw_kernel_codes)
    program_flow = ProgramFlow("main_entrance", global_env, "", lambda x: x)
    program_flow.generate_all_stmt_path()
    #the different structure
    statement_path = StatementPath()
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
                    if synchronization.has_halt_threads():
                        print "Has barrier divergence issue in " + str(synchronization.get_a_hold_stmt())
                        return
                    continue
                if kernel_codes.should_halt():
                    print_stmt("halt here because of __syncthreads() " + " in " + str(thread_indexes) + " in block " +
                               str(block_indexes), should_print)
                    continue
                current_stmt = kernel_codes.get_current_statement_and_set_next()
                #collect dynamical information
                branch_marking_function = kernel_codes.get_token_string()
                if branch_marking_function is None:
                    state = Statement(block_indexes, thread_indexes, current_stmt)
                    statement_path.add(state)
                else:
                    state = Statement(block_indexes, thread_indexes, branch_marking_function + "::" + current_stmt)
                    statement_path.add(state)
                local_env.add_value("current_stmt", current_stmt)
                print_stmt('execute ' + current_stmt + " in " + str(thread_indexes) + " in block " + str(block_indexes),
                           should_print)
                if detect_if_is_syncthreads(current_stmt):
                    synchronization.reach_one(thread_indexes, kernel_codes)
                    if synchronization.can_continue():
                        print 'last thread located here: ' + str(thread_indexes) + ", in block " + str(block_indexes)
                        while current_visited_global_memory_index.size() != 0:
                            visit_order_for_global_memory[current_visited_global_memory_index.pop()] += 1
                        while current_visited_shared_memory_index.size() != 0:
                            visit_order_for_shared_memory[current_visited_shared_memory_index.pop()] += 1
                else:
                    return_value, current_action, current_index, is_global = \
                        execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env, local_env)
                    if current_action is None:
                        continue
                    branch_marking_function = kernel_codes.get_token_string()
                    if branch_marking_function is None:
                        saved_action = Action((current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                               (threads.limit_x, threads.limit_y, threads.limit_z)))
                    else:
                        saved_action = Action((branch_marking_function + "::" + current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                               (threads.limit_x, threads.limit_y, threads.limit_z)))
                    if is_global:
                        if current_index > len(global_memory.list):
                            print "There is outraged here! plz noted."
                            continue
                        global_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_global_memory[current_index])
                        current_visited_global_memory_index.push(current_index)
                    else:
                        shared_memory.list[current_index].set_by_order(saved_action,
                                                                       visit_order_for_shared_memory[current_index])
                        current_visited_shared_memory_index.push(current_index)
        shared_parser(shared_memory, program_flow, statement_path)
    global_parser(global_memory, program_flow, statement_path)


def construct_memory_execute_mode_dynamically_for_barrier(blocks, threads, global_size, shared_size, raw_kernel_codes,
                                        arguments, shared_parser, global_parser, global_env=None, should_print=True):
        main_memory = arguments['main_memory']
        global_memory = GlobalMemory(global_size)
        warp_size = DataType("i32")
        warp_size.set_value(32)
        if global_env is None:
            global_env = Environment()
        global_env.add_value("@warpSize", warp_size)
        global_env.add_value("main_entrance", raw_kernel_codes)
        program_flow = ProgramFlow("main_entrance", global_env, "", lambda x: x)
        program_flow.generate_all_stmt_path()
        statement_path = StatementPath()
        for block_indexes in generator_for_dimension_var(blocks):

            global_env.add_value("@blockIdx", Block(block_indexes, (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
            global_env.add_value("@gridDim", Block((blocks.limit_x, blocks.limit_y, blocks.limit_z),
                                                   (blocks.limit_x, blocks.limit_y, blocks.limit_z)))
            shared_memory = SharedMemory(shared_size)
            visit_order_for_global_memory = [0 for i in xrange(global_size)]
            visit_order_for_shared_memory = [0 for i in xrange(shared_size)]
            current_visited_global_memory_index = StackSet()
            current_visited_shared_memory_index = StackSet()
            #  struct for collecting data for barrier function
            shared_barr = BarrierStackSet()
            global_barr = BarrierStackSet()
            shared_mem = MemDict()
            global_mem = MemDict()
            shared_flag = dict()
            global_flag = dict()
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
                        if synchronization.has_halt_threads():
                            print "Has barrier divergence issue in " + str(synchronization.get_a_hold_stmt())
                            return
                        continue
                    if kernel_codes.should_halt():
                        print_stmt(
                            "halt here because of __syncthreads() " + " in " + str(thread_indexes) + " in block " +
                            str(block_indexes), should_print)
                        continue
                    current_stmt = kernel_codes.get_current_statement_and_set_next()
                    branch_marking_function = kernel_codes.get_token_string()
                    if branch_marking_function is None:
                        state = Statement(block_indexes, thread_indexes, current_stmt)
                        statement_path.add(state)
                    else:
                        state = Statement(block_indexes, thread_indexes, branch_marking_function + "::" + current_stmt)
                        statement_path.add(state)

                    # current_stmt = kernel_codes.get_current_statement_and_set_next()
                    local_env.add_value("current_stmt", current_stmt)
                    print_stmt(
                        'execute ' + current_stmt + " in " + str(thread_indexes) + " in block " + str(block_indexes),
                        should_print)
                    if detect_if_is_syncthreads(current_stmt):
                        synchronization.reach_one(thread_indexes, kernel_codes)
                        if synchronization.can_continue():
                            print 'last thread located here: ' + str(thread_indexes) + ", in block " + str(
                                block_indexes)
                            if shared_flag.get(current_stmt) is None:
                                shared_flag[current_stmt] = True
                            if global_flag.get(current_stmt) is None:
                                global_flag[current_stmt] = True
                            while current_visited_global_memory_index.size() != 0:
                                global_index = current_visited_global_memory_index.pop()
                                global_mem.push(global_index, visit_order_for_global_memory[global_index])
                                global_barr.push(current_stmt, global_index,
                                                 visit_order_for_global_memory[global_index])
                                visit_order_for_global_memory[global_index] += 1
                            global_mem.set_flag()
                            while current_visited_shared_memory_index.size() != 0:
                                shared_index = current_visited_shared_memory_index.pop()
                                shared_mem.push(shared_index, visit_order_for_shared_memory[shared_index])
                                shared_barr.push(current_stmt, shared_index,
                                                 visit_order_for_shared_memory[shared_index])
                                visit_order_for_shared_memory[shared_index] += 1
                            shared_mem.set_flag()
                    else:
                        return_value, current_action, current_index, is_global = \
                            execute_statement_and_get_action(current_stmt, kernel_codes, main_memory, global_env,
                                                             local_env)
                        if current_action is None:
                            continue
                        branch_marking_function = kernel_codes.get_token_string()
                        if branch_marking_function is None:
                            saved_action = Action(
                                (current_stmt, current_line, current_action, block_indexes, thread_indexes,
                                 (threads.limit_x, threads.limit_y, threads.limit_z)))
                        else:
                            saved_action = Action((branch_marking_function + "::" + current_stmt, current_line,
                                                   current_action, block_indexes, thread_indexes,
                                                   (threads.limit_x, threads.limit_y, threads.limit_z)))
                        if is_global:
                            global_memory.list[current_index].set_by_order(saved_action,
                                                                           visit_order_for_global_memory[current_index])
                            current_visited_global_memory_index.push(current_index)
                        else:
                            shared_memory.list[current_index].set_by_order(saved_action,
                                                                           visit_order_for_shared_memory[current_index])
                            current_visited_shared_memory_index.push(current_index)
            shared_parser(shared_memory, program_flow, statement_path)
            has_no_necessarily_dynamically(shared_barr, shared_memory, shared_mem, program_flow, shared_flag, statement_path)
            shared_barr.clear()
            shared_mem.clear()
        global_parser(global_memory, program_flow, statement_path)
        has_no_necessarily_dynamically(global_barr, global_memory, global_mem, program_flow, global_flag, statement_path)
        global_barr.clear()
        global_mem.clear()
        necessity = True
        for barr in shared_flag:
            if barr in global_flag and (shared_flag[barr] and global_flag[barr]):
                necessity = False
            elif barr not in global_flag and shared_flag[barr]:
                necessity = False
        for barr in global_flag:
            if barr not in shared_flag and global_flag[barr]:
                necessity = False
        if not necessity:
            print '-------------------------------------------------------------------------------'
            print 'the barrier ' + barr + ' is not necessary.'
            print '-------------------------------------------------------------------------------'


def get_key_from_action(single_action):
    return str(single_action.block) + "+" + str(single_action.thread) + "+" + str(single_action.thread_dim)


def get_dim_from_action_key(action_key):
    return action_key.split("+")[2].strip()


def show_dict(target_dict):
    for key in target_dict:
        print key + ":  " + str(target_dict[key])


def has_not_equal_key(dict_one, dict_two):
    result = False
    for key in dict_one:
        if key not in dict_two:
            return True
    return result


def has_equal_key(dict_one, dict_two):
    for key in dict_one:
        if key in dict_two:
            return True
    return False


def is_in_same_warp(action_key_one, action_key_two, warp_size):
    def calculate_linear_index(thread_idx, block_dim):
        return (thread_idx[2] * block_dim[0] * block_dim[1]) + thread_idx[1] * block_dim[0] + thread_idx[0]
    action_one = [eval(item) for item in action_key_one.split("+")]
    action_two = [eval(item) for item in action_key_two.split("+")]
    if action_one[0] != action_two[0]:
        return False
    block_dim_size = action_one[2]
    thread_idx_one = action_one[1]
    thread_idx_two = action_two[1]
    index_action_one = calculate_linear_index(thread_idx_one, block_dim_size)
    index_action_two = calculate_linear_index(thread_idx_two, block_dim_size)
    return index_action_one / warp_size == index_action_two / warp_size


def has_stmt_in_different_branch(stmt_set_one, stmt_set_two, program_flow):
    stmt_map = program_flow.get_stmt_map()
    for stmt_one in stmt_set_one:
        for stmt_two in stmt_set_two:
            if stmt_one not in stmt_map or stmt_two not in stmt_map:
                new_stmt_one = stmt_one.split("::")
                new_stmt_two = stmt_two.split("::")
                start_index = 0
                min_range = min([len(new_stmt_one), len(new_stmt_two)])
                for index in xrange(min_range):
                    if new_stmt_two[index] != new_stmt_one[index]:
                        start_index = index
                        break
                if start_index - 1 >= 0:
                    target_function_pattern = r".*?(?P<function_name>[@][^(]+)\((?P<argus>.*)\)"
                    target_function_pattern = re.compile(target_function_pattern, re.DOTALL)
                    matcher = target_function_pattern.search(new_stmt_one[start_index - 1])
                    if program_flow.global_env.get_value(matcher.group("function_name")) is not None:
                        current_call = ProgramFlow(matcher.group("function_name"), program_flow.global_env, "", lambda x: x.raw_codes)
                        current_call.generate_all_stmt_path()
                        stmt_map = current_call.get_stmt_map()
                stmt_one = new_stmt_one[start_index]
                stmt_two = new_stmt_two[start_index]
            # if stmt_one not in stmt_map or stmt_two not in stmt_map:  # TODO how to handle code in different function
            #     continue
            if stmt_one not in stmt_map[stmt_two] and stmt_two not in stmt_map[stmt_one]:
                return True
    return False


def has_stmt_in_different_branch_dynamically(action_key_one, action_key_two, stmt_set_one, stmt_set_two, program_flow,
                                 statement_path):
    action_key_one = action_key_one.split("+")[0] + "+" + action_key_one.split("+")[1]
    action_key_two = action_key_two.split("+")[0] + "+" + action_key_two.split("+")[1]
    stmt_path_one = statement_path.path[str(action_key_one)]
    stmt_path_two = statement_path.path[str(action_key_two)]
    stmt_length = min(len(stmt_path_one), len(stmt_set_two))
    for index in range(stmt_length):
        if stmt_path_one[index] == stmt_set_one or stmt_path_two[index] == stmt_set_two:
            if stmt_path_one[index] == stmt_path_two[index]:
                return False
            else:
                return True
        if stmt_path_one[index] == stmt_path_two[index]:
            index += 1
        else:
            return True


def has_write_write_sync_issue(target_write_dict, program_flow):
    result_dict = dict()
    if len(target_write_dict) < 2:
        return result_dict
    for each_key in target_write_dict:
        for other_key in target_write_dict:
            if each_key == other_key:
                continue
            if is_in_same_warp(each_key, other_key, 32) and not has_stmt_in_different_branch(target_write_dict[each_key][1], target_write_dict[other_key][1], program_flow):
                if has_equal_key(target_write_dict[each_key][1], target_write_dict[other_key][1]):
                    result_dict[each_key] = target_write_dict[each_key]
                    result_dict[other_key] = target_write_dict[other_key]
            else:
                result_dict[each_key] = target_write_dict[each_key]
                result_dict[other_key] = target_write_dict[other_key]
    return result_dict


def has_write_write_sync_issue_dynamically(target_write_dict, program_flow, statement_path):
    result_dict = dict()
    if len(target_write_dict) < 2:
        return result_dict
    for each_key in target_write_dict:
        for other_key in target_write_dict:
            if each_key == other_key:
                continue
            if is_in_same_warp(each_key, other_key, 32) and not has_stmt_in_different_branch_dynamically(each_key, other_key, target_write_dict[each_key][1], target_write_dict[other_key][1], program_flow, statement_path):
                if has_equal_key(target_write_dict[each_key][1], target_write_dict[other_key][1]):
                    result_dict[each_key] = target_write_dict[each_key]
                    result_dict[other_key] = target_write_dict[other_key]
            else:
                result_dict[each_key] = target_write_dict[each_key]
                result_dict[other_key] = target_write_dict[other_key]
    return result_dict


def has_read_write_sync_issue(target_read_dict, target_write_dict, program_flow):
    result_write_dict = dict()
    result_read_dict = dict()
    if not (len(target_read_dict) >= 1 and len(target_write_dict) >= 1 and
            has_not_equal_key(target_read_dict, target_write_dict)):
        return result_read_dict, result_write_dict
    for each_key in target_read_dict:
        for other_key in target_write_dict:
            if each_key == other_key:
                continue
            if not is_in_same_warp(each_key, other_key, 32) or has_stmt_in_different_branch(target_read_dict[each_key][1], target_write_dict[other_key][1], program_flow):
                result_read_dict[each_key] = target_read_dict[each_key]
                result_write_dict[other_key] = target_write_dict[other_key]
    return result_read_dict, result_write_dict


def has_read_write_sync_issue_dynamically(target_read_dict, target_write_dict, program_flow, statement_path):
    result_write_dict = dict()
    result_read_dict = dict()
    if not (len(target_read_dict) >= 1 and len(target_write_dict) >= 1 and
            has_not_equal_key(target_read_dict, target_write_dict)):
        return result_read_dict, result_write_dict
    for each_key in target_read_dict:
        for other_key in target_write_dict:
            if each_key == other_key:
                continue
            if not is_in_same_warp(each_key, other_key, 32) or has_stmt_in_different_branch_dynamically(each_key, other_key, target_read_dict[each_key][1], target_write_dict[other_key][1], program_flow, statement_path):
                result_read_dict[each_key] = target_read_dict[each_key]
                result_write_dict[other_key] = target_write_dict[other_key]
    return result_read_dict, result_write_dict


def parse_target_memory_and_checking_sync(target_memory, program_flow):
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
                    current_key = get_key_from_action(single_action)
                    if current_key not in visit_write_dict:
                        visit_write_dict[current_key] = list(), dict()
                    if single_action.current_stmt not in visit_write_dict[current_key][1]:
                        visit_write_dict[current_key][0].append(single_action.current_stmt)
                        visit_write_dict[current_key][1][single_action.current_stmt] = True
                if single_action.action == 'read':
                    current_key = get_key_from_action(single_action)
                    if current_key not in visit_read_dict:
                        visit_read_dict[current_key] = list(), dict()
                    if single_action.current_stmt not in visit_read_dict[current_key][1]:
                        visit_read_dict[current_key][0].append(single_action.current_stmt)
                        visit_read_dict[current_key][1][single_action.current_stmt] = True
            if has_write:
                write_write_issue = has_write_write_sync_issue(visit_write_dict, program_flow)
                if len(write_write_issue) != 0:
                    print '-------------------------------------------------------------------------------'
                    print 'detect w&w synchronisation issue in ' + str(single_index)
                    print 'write:'
                    show_dict(write_write_issue)
                    print '-------------------------------------------------------------------------------'
                read_write_issue = has_read_write_sync_issue(visit_read_dict, visit_write_dict, program_flow)
                if len(read_write_issue[0]) != 0:
                    print '-------------------------------------------------------------------------------'
                    print 'detect r&w synchronisation issue in ' + str(single_index)
                    print 'read:'
                    show_dict(read_write_issue[0])
                    print 'write:'
                    show_dict(read_write_issue[1])
                    print '-------------------------------------------------------------------------------'

                # if len(visit_write_dict) >= 2:
                #     print 'detect w&w synchronisation issue in ' + str(single_index)
                #     print 'write:'
                #     show_dict(visit_write_dict)
                # if len(visit_read_dict) >= 1 and len(visit_write_dict) >= 1 and \
                #         has_not_equal_key(visit_read_dict, visit_write_dict):
                #     print 'detect r&w synchronisation issue in ' + str(single_index)
                #     print 'read:'
                #     show_dict(visit_read_dict)
                #     print 'write:'
                #     show_dict(visit_write_dict)


def parse_target_memory_and_checking_sync_dynamically(target_memory, program_flow, statement_path):
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
                    current_key = get_key_from_action(single_action)
                    if current_key not in visit_write_dict:
                        visit_write_dict[current_key] = list(), dict()
                    if single_action.current_stmt not in visit_write_dict[current_key][1]:
                        visit_write_dict[current_key][0].append(single_action.current_stmt)
                        visit_write_dict[current_key][1][single_action.current_stmt] = True
                if single_action.action == 'read':
                    current_key = get_key_from_action(single_action)
                    if current_key not in visit_read_dict:
                        visit_read_dict[current_key] = list(), dict()
                    if single_action.current_stmt not in visit_read_dict[current_key][1]:
                        visit_read_dict[current_key][0].append(single_action.current_stmt)
                        visit_read_dict[current_key][1][single_action.current_stmt] = True
            if has_write:
                write_write_issue = has_write_write_sync_issue_dynamically(visit_write_dict, program_flow, statement_path)
                if len(write_write_issue) != 0:
                    print '-------------------------------------------------------------------------------'
                    print 'detect w&w synchronisation issue in ' + str(single_index)
                    print 'write:'
                    show_dict(write_write_issue)
                    print '-------------------------------------------------------------------------------'
                read_write_issue = has_read_write_sync_issue_dynamically(visit_read_dict, visit_write_dict, program_flow, statement_path)
                if len(read_write_issue[0]) != 0:
                    print '-------------------------------------------------------------------------------'
                    print 'detect r&w synchronisation issue in ' + str(single_index)
                    print 'read:'
                    show_dict(read_write_issue[0])
                    print 'write:'
                    show_dict(read_write_issue[1])
                    print '-------------------------------------------------------------------------------'


def has_no_necessarily_dynamically(target_barr, target_memory, target_mem, program_flow, target_flag, statement_path):
    index = 0
    while index < len(target_barr.list):
        print index , len(target_barr.list)
        if not target_flag[target_barr.list[index]]:
            index += 1
            continue
        next_index = index
        jmp = index
        last = False
        for next in range(0, len(target_mem.flag)):
            if next_index < target_mem.flag[next] + 1:
                next_index = target_mem.flag[next] + 1
                if next < len(target_mem.flag)-1:
                    jmp = target_mem.flag[next+1] + 1
                else:
                    jmp = next_index
                break
        if next_index == jmp:
            last = True
            next_index = index
        for next in range(next_index, jmp):
            print next
            if not target_flag[target_barr.list[index]]:
                break
            new_memory = target_barr.build_memory(target_memory, index, jmp, next, target_mem, last)
            if last and new_memory.flag:
                continue
            memory_lst = new_memory.list
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
                            current_key = get_key_from_action(single_action)
                            if current_key not in visit_write_dict:
                                visit_write_dict[current_key] = list(), dict()
                            if single_action.current_stmt not in visit_write_dict[current_key][1]:
                                visit_write_dict[current_key][0].append(single_action.current_stmt)
                                visit_write_dict[current_key][1][single_action.current_stmt] = True
                        if single_action.action == 'read':
                            current_key = get_key_from_action(single_action)
                            if current_key not in visit_read_dict:
                                visit_read_dict[current_key] = list(), dict()
                            if single_action.current_stmt not in visit_read_dict[current_key][1]:
                                visit_read_dict[current_key][0].append(single_action.current_stmt)
                                visit_read_dict[current_key][1][single_action.current_stmt] = True
                    if has_write:
                        write_write_issue = has_write_write_sync_issue_dynamically(visit_write_dict, program_flow, statement_path)
                        read_write_issue = has_read_write_sync_issue_dynamically(visit_read_dict, visit_write_dict, program_flow, statement_path)
                        if len(read_write_issue[0]) != 0 or len(write_write_issue) != 0:
                            target_flag[target_barr.list[index]] = False
        index = next_index
        if last:
            break


def has_no_necessarily(target_barr, target_memory, target_mem, program_flow, target_flag):
    index = 0
    while index < len(target_barr.list):
        if not target_flag[target_barr.list[index]]:
            index += 1
            continue
        next_index = index
        jmp = index
        last = False
        for next in range(0, len(target_mem.flag)):
            if next_index < target_mem.flag[next] + 1:
                next_index = target_mem.flag[next] + 1
                if next < len(target_mem.flag)-1:
                    jmp = target_mem.flag[next+1] + 1
                else:
                    jmp = next_index
                break
        if next_index == jmp:
            last = True
            next_index = index
        for next in range(next_index, jmp):
            if not target_flag[target_barr.list[index]]:
                break
            new_memory = target_barr.build_memory(target_memory, index, jmp, next, target_mem, last)
            if last and new_memory.flag:
                continue
            memory_lst = new_memory.list
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
                            current_key = get_key_from_action(single_action)
                            if current_key not in visit_write_dict:
                                visit_write_dict[current_key] = list(), dict()
                            if single_action.current_stmt not in visit_write_dict[current_key][1]:
                                visit_write_dict[current_key][0].append(single_action.current_stmt)
                                visit_write_dict[current_key][1][single_action.current_stmt] = True
                        if single_action.action == 'read':
                            current_key = get_key_from_action(single_action)
                            if current_key not in visit_read_dict:
                                visit_read_dict[current_key] = list(), dict()
                            if single_action.current_stmt not in visit_read_dict[current_key][1]:
                                visit_read_dict[current_key][0].append(single_action.current_stmt)
                                visit_read_dict[current_key][1][single_action.current_stmt] = True
                    if has_write:
                        write_write_issue = has_write_write_sync_issue(visit_write_dict, program_flow)
                        read_write_issue = has_read_write_sync_issue(visit_read_dict, visit_write_dict, program_flow)
                        if len(read_write_issue[0]) != 0 or len(write_write_issue) != 0:
                            target_flag[target_barr.list[index]] = False
        index = next_index
        if last:
            break

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
    args = {
        "%input_array": DataType("i32*"),
        "%num_elements": num_elements,
        "main_memory": {
            "global": "%input_array",
            "shared": None
        }
    }
    args['%input_array'].set_value("%input_array")
    # args = {
    #     "%x": DataType("i32*"),
    #     "%dim": num_elements,
    #     "main_memory": {
    #         "global": "%x",
    #         "shared": None
    #     }
    # }
    # args["%x"].set_value("%x")
    test_global_size = 100
    test_shared_size = 256
    codes = open('./tests.ll', 'r').read()
    test_global_env = Environment()
    memory_container = MemoryContainer()

    test_global_env.add_value("memory_container", memory_container)
    construct_memory_execute_mode(test_block, test_thread, test_global_size, test_shared_size, codes, args,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync,
                                  test_global_env, False)
