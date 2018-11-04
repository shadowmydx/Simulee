from multiprocessing import Process, Manager, Queue
import collections


def _new_fitness(input_queue, output_queue, fitness):
    while True:
        new_item = input_queue.get()
        output_queue.put((new_item, fitness(new_item)))


class FitnessProcess:

    def __init__(self, process_limited):
        self.pool = list()
        self.process_limited = process_limited
        self.input_queue = Queue()
        self.output_queue = Queue()
        self.current_task = 0

    def setup_fitness(self, fitness):
        for i in xrange(self.process_limited):
            self.pool.append(Process(target=_new_fitness, args=(self.input_queue, self.output_queue, fitness)))
        for single_process in self.pool:
            single_process.start()

    def send_item(self, target_item):
        self.current_task += 1
        self.input_queue.put(target_item)

    def close(self):
        for i in xrange(self.process_limited):
            self.pool[i].terminate()

    def __iter__(self):
        return self

    def next(self):
        if self.current_task == 0:
            raise StopIteration()
        self.current_task -= 1
        return self.output_queue.get()


def evolutionary_framework(generation, population, generator, sorter,
                           fitness, acceptable, selector, mutation, crossover, process_limited):
    process_pool = FitnessProcess(process_limited)
    process_pool.setup_fitness(fitness)
    population_lst = generator(population)
    for single_item in population_lst:
        process_pool.send_item(single_item)
    population_lst = list()
    for single_item in process_pool:
        population_lst.append(single_item)
    population_lst = sorter(population_lst)
    print "finished."
    for i in range(generation):
        print "In " + str(i) + " generation:"
        child_lst = list()
        for single_item in population_lst:
            if selector(single_item, population_lst):
                if mutation is not None:
                    result_item = mutation(single_item)
                    if isinstance(result_item, collections.Iterable):
                        child_lst += result_item
                    else:
                        child_lst.append(result_item)
                if crossover is not None:
                    child_lst.append(crossover(single_item, population_lst))
        for single_item in child_lst:
            process_pool.send_item(single_item)
        child_lst = list()
        for single_item in process_pool:
            child_lst.append(single_item)
        population_lst += child_lst
        population_lst = sorter(population_lst)
        population_lst = population_lst[: population]
        if acceptable is not None and acceptable(population_lst[0]):
            process_pool.close()
            return population_lst
    process_pool.close()
    return population_lst


def evolutionary_framework_local(generation, population, generator, sorter, fitness,
                                 acceptable, selector, mutation, crossover):
    population_lst = generator(population)
    population_lst = [(item, fitness(item)) for item in population_lst]
    population_lst = sorter(population_lst)
    for i in range(generation):
        child_lst = list()
        for single_item in population_lst:
            if selector(single_item, population_lst):
                if mutation is not None:
                    result_item = mutation(single_item)
                    if isinstance(result_item, collections.Iterable):
                        child_lst += result_item
                    else:
                        child_lst.append(result_item)
                if crossover is not None:
                    child_lst.append(crossover(single_item, population_lst))
        child_lst = [(item, fitness(item)) for item in child_lst]
        population_lst += child_lst
        population_lst = sorter(population_lst)
        population_lst = population_lst[: population]
        print "In " + str(i) + " generation: "
        print population_lst
        if acceptable is not None and acceptable(population_lst[0]):
            return population_lst
    return population_lst

