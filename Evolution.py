from MemHeuristic import *
from EvolutionaryFramework import *
import numpy as np


class ArgumentsItem:

    def __init__(self, target_file, target_function_name, main_memory, blocks, threads):
        self.codes, self.global_env, self.should_evolution, all_variables = \
            generate_heuristic_code(target_file, target_function_name, main_memory)
        self.target_file = target_file
        self.target_function_name = target_function_name
        self.codes = '\n'.join([item[0] for item in self.codes])
        self.initial_argus = self.construct_argus_dict(all_variables)
        self.type_dict = self.construct_dict_from_tuple(all_variables)
        self.father_item = None
        self.father_generate = None
        self.score = None
        self.main_memory = main_memory
        self.function_name = target_function_name
        self.blocks = blocks
        self.threads = threads

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
        normal_item = ArgumentsItem(self.target_file, self.target_function_name, self.main_memory, self.blocks, self.threads)
        cauchy_item = ArgumentsItem(self.target_file, self.target_function_name, self.main_memory, self.blocks, self.threads)
        normal_item.father_item = self
        self.copy_initial_argus_to_target(normal_item)
        normal_item.father_generate = "normal"
        cauchy_item.father_item = self
        self.copy_initial_argus_to_target(cauchy_item)
        cauchy_item.father_generate = "cauchy"
        for item in self.should_evolution:
            normal_item.initial_argus[item[0]] += np.random.normal()
            cauchy_item.initial_argus[item[0]] += np.random.standard_cauchy()
        return normal_item, cauchy_item

    def fitness(self):
        generate_memory_container([], self.global_env)
        number_arguments = self.construct_running_arguments()
        arguments = generate_arguments(self.global_env.get_value(self.function_name), number_arguments)
        arguments["main_memory"] = self.main_memory
        global_access, shared_access = execute_heuristic(self.blocks, self.threads, self.codes, arguments, self.global_env, False)
        global_count = self.count_total_access(global_access[0])
        shared_count = self.count_total_access(shared_access[0])
        self.score = (len(global_access[0]) + len(shared_access[0])) / float(global_count + shared_count)
        return self.score

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


def evolutionary_item_factory(target_file, target_function_name, main_memory, blocks, threads):

    def _generator():
        return ArgumentsItem(target_file, target_function_name, main_memory, blocks, threads)

    return _generator


def fitness(item):
    return item.fitness()


def mutation(item):
    return item[0].mutation()


def sorter(population_lst):
    population_lst.sort(key=lambda x: x[1])
    return population_lst


def selector(item, population_lst):
    return True


def acceptable(item):
    return item[1] <= 0.5


def generator_for_evolutionary_factory(target_generator):

    def _generator(population):
        result_lst = list()
        for i in xrange(population):
            result_lst.append(target_generator())
        return result_lst

    return _generator

if __name__ == "__main__":
    t_generator = evolutionary_item_factory("./kaldi-new-bug/new-func.ll", "@_Z13_copy_low_uppPfii", {
        "global": "%A",
        "shared": None
    }, Block((-1, -1, 0), (1, 1, 1)), Thread((-1, -1, 0), (3, 1, 1)))
    t_item = t_generator()
    t_item.fitness()
    t_generator = generator_for_evolutionary_factory(t_generator)

    population_lst = evolutionary_framework_local(8, 50, t_generator, sorter, fitness, acceptable, selector, mutation, None)
    for _item in population_lst:
        print _item[0].construct_running_arguments(), _item[0].father_generate
