from MemHeuristic import *
from EvolutionaryFramework import *
import numpy as np
import time


class DimensionFactory:

    def __init__(self, block_limited, thread_limited, block_dimension, thread_dimension):
        self.block_limited = block_limited
        self.thread_limited = thread_limited
        self.block_dimension = block_dimension
        self.thread_dimension = thread_dimension

    def mutation(self, current_tuple, is_block):
        current_limited = self.block_limited if is_block else self.thread_limited
        current_dimension = self.block_dimension if is_block else self.thread_dimension
        current_class = Block if is_block else Thread
        direction_vector = np.random.randint(low=-1, high=2, size=current_dimension)
        direction_vector = list(direction_vector)
        current_lst = [item for item in current_tuple]
        for i in xrange(len(direction_vector)):
            current_lst[i] += direction_vector[i]
        for i in xrange(len(current_lst)):
            if current_lst[i] < 1:
                current_lst[i] = 1
            elif current_lst[i] > current_limited:
                current_lst[i] = current_limited
        return current_class((-1, -1, 0), tuple(current_lst))

    def random_dimension(self, is_block):
        current_limited = self.block_limited if is_block else self.thread_limited
        current_dimension = self.block_dimension if is_block else self.thread_dimension
        current_class = Block if is_block else Thread
        dimension_vector = np.random.randint(low=1, high=current_limited + 1, size=current_dimension)
        dimension_vector = list(dimension_vector)
        for i in xrange(len(dimension_vector), 3):
            dimension_vector.append(1)
        return current_class((-1, -1, 0), tuple(dimension_vector))


def class_generator(target_file, target_function_name, main_memory, is_branch=False):
    if not is_branch:
        heuristic_content = generate_heuristic_code(target_file, target_function_name, main_memory)
    else:
        heuristic_content = generate_branch_heuristic_code(target_file, target_function_name)
    dimension_handler = DimensionFactory(3, 5, heuristic_content[4][0], heuristic_content[4][1])
    return heuristic_content, dimension_handler


class ArgumentsItem:
    def __init__(self, target_file, target_function_name, main_memory,
                 heuristic_content, blocks, threads, evolve_dimension=False):
        self.heuristic_content = heuristic_content
        self.codes, self.global_env, self.should_evolution, all_variables, self.dimension = \
            heuristic_content[0]
        self.target_file = target_file
        self.target_function_name = target_function_name
        self.codes = '\n'.join([item[0] for item in self.codes])
        self.initial_argus = self.construct_argus_dict(all_variables)
        self.type_dict = self.construct_dict_from_tuple(all_variables)
        self.father_item = None
        self.father_generate = None
        self.step_size = 0
        self.score = None
        self.main_memory = main_memory
        self.function_name = target_function_name
        self.dimension_handler = heuristic_content[1]
        self.evolve_dimension = evolve_dimension
        if evolve_dimension:  # for initialized
            self.blocks = self.dimension_handler.random_dimension(True)
            self.threads = self.dimension_handler.random_dimension(False)
        else:
            self.blocks = blocks
            self.threads = threads
        self.global_access = None
        self.shared_access = None
        self.second_score = 0

    @staticmethod
    def construct_argus_dict(variable_lst):
        result_dict = dict()
        for item in variable_lst:
            result_dict[item[0]] = 10 * abs(np.random.standard_cauchy())
        return result_dict

    def copy_initial_argus_to_target(self, target_item):
        for key in target_item.initial_argus:
            target_item.initial_argus[key] = self.initial_argus[key]

    def construct_running_arguments(self):
        number_arguments = dict()
        for each_var in self.initial_argus:
            if self.type_dict[each_var].find("i") != -1:
                number_arguments[each_var] = int(self.initial_argus[each_var])
            else:
                number_arguments[each_var] = self.initial_argus[each_var]
        return number_arguments

    def mutation(self):
        if self.evolve_dimension:
            normal_item = ArgumentsItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.dimension_handler.mutation(self.blocks.grid_dim, True),
                                        self.dimension_handler.mutation(self.threads.block_dim, False))
            cauchy_item = ArgumentsItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.dimension_handler.mutation(self.blocks.grid_dim, True),
                                        self.dimension_handler.mutation(self.threads.block_dim, False))
            normal_item.evolve_dimension = True
            cauchy_item.evolve_dimension = True
        else:
            normal_item = ArgumentsItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.blocks, self.threads)
            cauchy_item = ArgumentsItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.blocks, self.threads)
        normal_item.father_item = self
        self.copy_initial_argus_to_target(normal_item)
        normal_item.father_generate = "normal"
        cauchy_item.father_item = self
        self.copy_initial_argus_to_target(cauchy_item)
        cauchy_item.father_generate = "cauchy"
        for item in self.should_evolution:
            normal_random_gap = np.random.normal()
            normal_item.initial_argus[item[0]] += normal_random_gap
            normal_item.step_size += normal_random_gap ** 2
            cauchy_random_gap = np.random.standard_cauchy()
            cauchy_item.initial_argus[item[0]] += cauchy_random_gap
            cauchy_item.step_size += cauchy_random_gap ** 2
        cauchy_item.step_size = np.sqrt(cauchy_item.step_size)
        normal_item.step_size = np.sqrt(normal_item.step_size)
        return normal_item, cauchy_item

    def get_vector_format_for_all_item(self):
        result_lst = list()
        for item in self.blocks.grid_dim:
            result_lst.append(item)
        for item in self.threads.block_dim:
            result_lst.append(item)
        for item in self.should_evolution:
            result_lst.append(self.initial_argus[item[0]])
        return result_lst

    def fitness(self):
        memory_lst = list()
        if self.main_memory["shared"] is not None:
            memory_lst.append(self.main_memory["shared"])
        generate_memory_container(memory_lst, self.global_env)
        number_arguments = self.construct_running_arguments()
        arguments = generate_arguments(self.global_env.get_value(self.function_name), number_arguments)
        arguments["main_memory"] = self.main_memory
        try:
            self.global_access, self.shared_access = execute_heuristic(self.blocks, self.threads, self.codes, arguments,
                                                                       self.global_env, False)
        except ZeroDivisionError:
            self.score = 1
            return self.score
        global_count = self.count_total_access(self.global_access[0])
        shared_count = self.count_total_access(self.shared_access[0])
        if global_count + shared_count == 0:
            self.score = 2  # no memory access here
            return 2
        self.score = (len(self.global_access[0]) + len(self.shared_access[0])) / float(global_count + shared_count)
        return self.score

    def second_fitness(self):
        if self.score == 2:
            self.second_score = 200
            return self.second_score
        if self.global_access is None:
            self.second_score = 1000
            return self.second_score
        global_index = self.global_access[0].keys()
        shared_index = self.shared_access[0].keys()
        global_index.sort()
        shared_index.sort()
        global_second_score = [global_index[index] - global_index[index - 1] for index in xrange(1, len(global_index))]
        shared_second_score = [shared_index[index] - shared_index[index - 1] for index in xrange(1, len(shared_index))]
        self.second_score = sum(global_second_score) + sum(shared_second_score)
        return self.second_score

    @staticmethod
    def count_total_access(param_dict):
        access_count = 0
        for key in param_dict:
            access_count += len(param_dict[key])
        return access_count

    @staticmethod
    def construct_dict_from_tuple(all_variables):
        result_dict = dict()
        for item in all_variables:
            result_dict[item[0]] = item[1]
        return result_dict


class BranchItem(ArgumentsItem):

    def __init__(self, target_file, target_function_name, main_memory,
                 heuristic_content, blocks, threads, evolve_dimension=False):
        ArgumentsItem.__init__(self, target_file, target_function_name, main_memory,
                               heuristic_content, blocks, threads, evolve_dimension)
        self.total_label = len([item for item in self.codes.split("\n") if item.find("<label>") != -1])

    def fitness(self):
        generate_memory_container([], self.global_env)
        number_arguments = self.construct_running_arguments()
        arguments = generate_arguments(self.global_env.get_value(self.function_name), number_arguments)
        arguments["main_memory"] = self.main_memory
        access_label_dict = execute_branch_heuristic(self.blocks, self.threads, self.codes,
                                                     arguments, self.global_env, False)
        return -len(access_label_dict)

    def second_fitness(self):
        return self.total_label

    @staticmethod
    def construct_argus_dict(variable_lst):
        result_dict = dict()
        for item in variable_lst:
            result_dict[item[0]] = np.random.uniform(low=0, high=10)
        return result_dict

    def mutation(self):
        if self.evolve_dimension:
            normal_item = BranchItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.dimension_handler.mutation(self.blocks.grid_dim, True),
                                        self.dimension_handler.mutation(self.threads.block_dim, False))
            cauchy_item = BranchItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.dimension_handler.mutation(self.blocks.grid_dim, True),
                                        self.dimension_handler.mutation(self.threads.block_dim, False))
            normal_item.evolve_dimension = True
            cauchy_item.evolve_dimension = True
        else:
            normal_item = BranchItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.blocks, self.threads)
            cauchy_item = BranchItem(self.target_file, self.target_function_name, self.main_memory,
                                        self.heuristic_content, self.blocks, self.threads)
        normal_item.father_item = self
        self.copy_initial_argus_to_target(normal_item)
        normal_item.father_generate = "normal"
        cauchy_item.father_item = self
        self.copy_initial_argus_to_target(cauchy_item)
        cauchy_item.father_generate = "cauchy"
        for item in self.should_evolution:
            normal_random_gap = np.random.normal()
            normal_item.initial_argus[item[0]] += normal_random_gap
            normal_item.step_size += normal_random_gap ** 2
            cauchy_random_gap = np.random.standard_cauchy()
            cauchy_item.initial_argus[item[0]] += cauchy_random_gap
            cauchy_item.step_size += cauchy_random_gap ** 2
        cauchy_item.step_size = np.sqrt(cauchy_item.step_size)
        normal_item.step_size = np.sqrt(normal_item.step_size)
        return normal_item, cauchy_item


def evolutionary_item_factory(target_file, target_function_name, main_memory, blocks, threads, dimension=False, is_branch=False):

    class_arguments = class_generator(target_file, target_function_name, main_memory, is_branch)

    def _generator():
        return ArgumentsItem(target_file, target_function_name, main_memory, class_arguments, blocks, threads, dimension)

    def _branch_generator():
        return BranchItem(target_file, target_function_name, main_memory, class_arguments, blocks, threads, dimension)

    return _branch_generator if is_branch else _generator


def fitness(item):
    real_score = item.fitness()
    second_score = item.second_fitness()
    return real_score, second_score


def mutation(item):
    return item[0].mutation()


def sorter(population_lst):
    population_lst.sort(key=lambda x: x[1][0])
    if population_lst[0][1][0] == population_lst[-1][1][0]:
        population_lst.sort(key=lambda x: x[1][1])
        if population_lst[0][1][1] == population_lst[-1][1][1]:
            population_lst.sort(key=lambda x: x[0].step_size)
            population_lst.reverse()
    return population_lst


def selector(item, population_lst):
    return True


def acceptable_factory(is_branch):

    def _acceptable(item_lst):
        return item_lst[0][1][0] < .3
        # score_lst = [item[1] for item in item_lst if item[1] < .7]
        # return len(score_lst) >= len(item_lst) / 5

    def _acceptable_branch(item_lst):
        return item_lst[0][1][0] == -item_lst[0][1][1]

    return _acceptable_branch if is_branch else _acceptable


def generator_for_evolutionary_factory(target_generator):

    def _generator(population):
        result_lst = list()
        for i in xrange(population):
            result_lst.append(target_generator())
        return result_lst

    return _generator


def show_evolution_path(target_item):
    result_lst = list()
    while target_item is not None:
        result_lst.append(target_item.father_generate)
        target_item = target_item.father_item
    result_lst.reverse()
    return result_lst


def generate_initialized_setting(target_file_path, function_name, main_memory, is_branch=False, test_round=1,
                                 evolve_dimension=True, fixed_dimension=None):
    failed = 0
    total_generation = 0
    test_result_lst = list()
    if fixed_dimension is None:
        fixed_dimension = [(1, 1, 1), (34, 1, 1)]
    for i in xrange(test_round):
        start_time = time.time()
        generator = evolutionary_item_factory(target_file_path, function_name, main_memory,
                                              Block((-1, -1, 0), fixed_dimension[0]),
                                              Thread((-1, -1, 0), fixed_dimension[1]), evolve_dimension, is_branch)
        generator = generator_for_evolutionary_factory(generator)

        population_lst, current_generation = evolutionary_framework(3, 50, generator, sorter, fitness, acceptable_factory(is_branch), selector, mutation, None, 10)
        # population_lst, current_generation = evolutionary_framework_local(20, 1, generator, sorter, fitness, acceptable_factory(is_branch), selector, mutation, None)
        if population_lst[0][1][0] >= 1:
            print population_lst[0][1][0]
            failed += 1
        total_generation += current_generation + 1
        for item in population_lst:
            if item[1][0] < 1:
                print item[0].blocks.grid_dim, item[0].threads.block_dim, item[0].construct_running_arguments()
        # for _item in _population_lst:
        #     print _item[0].construct_running_arguments(), show_evolution_path(_item[0])
        print "cost is " + str(time.time() - start_time)
        print "current failed is " + str(failed)
        print "current test round is " + str(i)
        print "========================================================="
        test_result_lst.append(population_lst)
    print "average generation: " + str(total_generation / test_round)
    print "total failed in 50 generation: " + str(failed)
    return test_result_lst[0]


def auto_test_target_function(target_file_path, function_name, main_memory, used_default_dimension=False, fixed_dimension=None):
    start_time = time.time()
    solution_lst = generate_initialized_setting(target_file_path, function_name, main_memory,
                                                evolve_dimension=not used_default_dimension, fixed_dimension=fixed_dimension)
    used_solution = dict()
    for item in solution_lst:
        if item[1][0] < 1:
            solution_str = str(item[0].blocks.grid_dim) + str(item[0].threads.block_dim) + str(item[0].construct_running_arguments())
            if solution_str in used_solution:
                continue
            used_solution[solution_str] = True
            global_env = parse_function(target_file_path)
            generate_memory_container(main_memory.keys(), global_env)
            raw_code = global_env.get_value(function_name)
            blocks = item[0].blocks
            threads = item[0].threads
            arguments = item[0].construct_running_arguments()
            for idx, variable in enumerate(raw_code.argument_lst):
                if variable not in arguments and raw_code.type_lst[idx].find("*") == -1:
                    arguments[variable] = 2  # temp action, need more focus
            arguments = generate_arguments(global_env.get_value(function_name), arguments)
            arguments["main_memory"] = main_memory
            execute_framework(blocks, threads, raw_code.raw_codes, arguments, global_env)
            current_time = time.time()
            print "Current solution total cost time is " + str(current_time - start_time)


def auto_test_target_function_dynamical(target_file_path, function_name, main_memory, used_default_dimension=False, fixed_dimension=None):
    start_time = time.time()
    solution_lst = generate_initialized_setting(target_file_path, function_name, main_memory,
                                                evolve_dimension=not used_default_dimension, fixed_dimension=fixed_dimension)
    used_solution = dict()
    for item in solution_lst:
        if item[1][0] < 1:
            solution_str = str(item[0].blocks.grid_dim) + str(item[0].threads.block_dim) + str(item[0].construct_running_arguments())
            if solution_str in used_solution:
                continue
            used_solution[solution_str] = True
            global_env = parse_function(target_file_path)
            generate_memory_container(main_memory.keys(), global_env)
            raw_code = global_env.get_value(function_name)
            blocks = item[0].blocks
            threads = item[0].threads
            arguments = item[0].construct_running_arguments()
            for idx, variable in enumerate(raw_code.argument_lst):
                if variable not in arguments and raw_code.type_lst[idx].find("*") == -1:
                    arguments[variable] = 2  # temp action, need more focus
            arguments = generate_arguments(global_env.get_value(function_name), arguments)
            arguments["main_memory"] = main_memory
            execute_framework_dynamical(blocks, threads, raw_code.raw_codes, arguments, global_env)
            current_time = time.time()
            print "Current solution total cost time is " + str(current_time - start_time)


def auto_test_target_function_advanced(target_file_path, function_name, main_memory,
                                       used_default_dimension=False, fixed_dimension=None):
    solution_lst = generate_initialized_setting(target_file_path, function_name, main_memory,
                                                evolve_dimension=not used_default_dimension,
                                                fixed_dimension=fixed_dimension)
    used_solution = dict()
    if solution_lst[0][1][0] >= 1:
        print("=========================================================")
        print("In case that no conflicts, so all barrier functions located in original code are redundant.")
        print("=========================================================")
    for item in solution_lst:
        if item[1][0] < 1:
            solution_str = str(item[0].blocks.grid_dim) + str(item[0].threads.block_dim) + str(item[0].construct_running_arguments())
            if solution_str in used_solution:
                continue
            used_solution[solution_str] = True
            global_env = parse_function(target_file_path)
            generate_memory_container(main_memory.keys(), global_env)
            raw_code = global_env.get_value(function_name)
            blocks = item[0].blocks
            threads = item[0].threads
            arguments = item[0].construct_running_arguments()
            for idx, variable in enumerate(raw_code.argument_lst):
                if variable not in arguments and raw_code.type_lst[idx].find("*") == -1:
                    arguments[variable] = 2  # temp action, need more focus
            arguments = generate_arguments(global_env.get_value(function_name), arguments)
            arguments["main_memory"] = main_memory
            execute_framework_advanced(blocks, threads, raw_code.raw_codes, arguments, global_env)


if __name__ == "__main__":
    # auto_test_target_function("./kaldi-new-bug/fse-func.ll", "@_Z11_sum_reducePd", {
    #     "global": "%buffer",
    #     "shared": None
    # })  # race & unnecessary
    # auto_test_target_function("./cuda-convnet2-new-bug/new-func.ll", "@_Z13kDotProduct_rPfS_S_j", {
    #     "global": None,
    #     "shared": "@_ZZ13kDotProduct_rPfS_S_jE5shmem"
    # }, fixed_dimension=[(2, 1, 1), (3, 3, 1)], used_default_dimension=True)
    # auto_test_target_function("./cuda-convnet2-new-bug/new-func.ll", "@_Z5kTilePKfPfjjjj", {
    #     "global": "%tgt",
    #     "shared": None
    # }, fixed_dimension=[(2, 2, 1), (3, 1, 1)], used_default_dimension=True)
    # auto_test_target_function("./read_write_test.ll", "@_Z13device_globalPji", {
    #     "global": "%input_array",
    #     "shared": None
    # })
    # auto_test_target_function("./arrayfire-new-bug/new-func.ll", "@_Z9convolve2PiS_iS_S_S_S_iiiiiiii", {
    #     "global": None,
    #     "shared": "_ZZ9convolve2PiS_iS_S_S_S_iiiiiiiiE7shrdMem"
    # })
    # auto_test_target_function("./cudatree/new-func.ll", "@_Z7predictPjS_PtPfPiS2_S2_ii", {
    #     "global": "%predict_res",
    #     "shared": None
    # })
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_low_uppPfii", {
    #     "global": "%A",
    #     "shared": None
    # })
    auto_test_target_function("./thundersvm-new-bug/new-fun.ll", "@_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i", {
        "global": "%alpha",
        "shared": "@_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem"
    }, used_default_dimension=True)
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z17_add_diag_vec_matfPfiiiPKfS1_iif", {
    #     "global": "%mat",
    #     "shared": None
    # })
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z20_trace_mat_mat_transPKfS0_iiiiPf", {
    #     "global": None,
    #     "shared": "@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"
    # })
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_upp_lowPfii", {
    #     "global": "%A",
    #     "shared": None
    # })
    # auto_test_target_function("./gunrock/fse-func.ll", "@_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_", {
    #     "global": "%froms_out",
    #     "shared": None
    # }, fixed_dimension=[(2, 1, 1), (33, 1, 1)], used_default_dimension=True)
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z14_copy_from_matPfPKfiiii", {
    #     "global": "%mat_out",
    #     "shared": None
    # })
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z20_trace_mat_mat_transPKfS0_iiiiPf", {
    #     "global": None,
    #     "shared": "@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"
    # })
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z7_splicePfPKfPKiiiiiii", {
    #     "global": "%y",
    #     "shared": None
    # })
    # auto_test_target_function("./kaldi-new-bug/new-func.ll", "@_Z13_copy_from_tpPfPKfiii", {
    #     "global": "%A",
    #     "shared": None
    # })
    # generate_initialized_setting("./kaldi-new-bug/new-func.ll", "@_Z17_add_diag_vec_matfPfiiiPKfS1_iif", {
    #     "global": "%mat",
    #     "shared": None
    # })
    # generate_initialized_setting("./kaldi-new-bug/new-func.ll", "@_Z20_trace_mat_mat_transPKfS0_iiiiPf", {
    #     "global": None,
    #     "shared": "@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum"
    # })
    # generate_initialized_setting("./arrayfire/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.ll", "@_Z14select_matchesPjPiPKjPKijji", {
    #     "global": None,
    #     "shared": "@_ZZ14select_matchesPjPiPKjPKijjiE6s_dist"
    # })

