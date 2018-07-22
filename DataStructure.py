import re


# if is a memory pointer, value start with ("%")
# memory-index: data_type: memory-index value: memory based value is_get: true memory_index: int
class DataType(object):

    def __init__(self, data_type):
        super(DataType, self).__init__()
        self.data_type = data_type
        self.value = None  # value.start_with("%")
        self.is_getelementptr = False
        self.memory_index = None  # only active when is_getelementptr is True
        self.is_depend_on_running_time = False  # if this value can only be specify during running time

    def copy_and_replace(self, other_type):
        other_type.data_type = self.data_type
        other_type.value = self.value
        other_type.is_getelementptr = self.is_getelementptr
        other_type.memory_index = self.memory_index
        other_type.is_depend_on_running_time = self.is_depend_on_running_time

    def set_value(self, value):
        self.value = value

    def set_type(self, data_type):
        self.data_type = data_type

    def get_value(self):
        return self.value

    def get_type(self):
        return self.data_type

    def set_is_getelementptr(self, new_bool):
        self.is_getelementptr = new_bool

    def set_memory_index(self, index):
        self.memory_index = index

    def set_is_depend_on_running_time(self, new_bool):
        self.is_depend_on_running_time = new_bool


class Thread(DataType):

    def __init__(self, location, block_dim):
        super(Thread, self).__init__("build-in")
        type_lst = list()
        for item in location:
            tmp_data = DataType('i32')
            tmp_data.set_value(item)
            type_lst.append(tmp_data)
        self.set_value(type_lst)
        self.limit_x, self.limit_y, self.limit_z = block_dim


class Block(DataType):

    def __init__(self, location, grid_dim):
        super(Block, self).__init__("build-in")
        type_lst = list()
        for item in location:
            tmp_data = DataType('i32')
            tmp_data.set_value(item)
            type_lst.append(tmp_data)
        self.set_value(type_lst)
        self.limit_x, self.limit_y, self.limit_z = grid_dim


class Action(object):

    def __init__(self, actions):
        super(Action, self).__init__()
        self.current_stmt, self.line, self.action, self.block, self.thread = actions


class SingleMemoryItem(object):

    def __init__(self, current_index):
        super(SingleMemoryItem, self).__init__()
        self.index = current_index
        self.visit_lst = list()

    def set_by_order(self, action, order):
        while len(self.visit_lst) <= order:
            self.visit_lst.append(list())
        self.visit_lst[order].append(action)


class GlobalMemory(object):

    def __init__(self, size):
        super(GlobalMemory, self).__init__()
        self.list = list()
        for index in xrange(size):
            self.list.append(SingleMemoryItem(index))


class SharedMemory(object):

    def __init__(self, size):
        super(SharedMemory, self).__init__()
        self.list = list()
        for index in xrange(size):
            self.list.append(SingleMemoryItem(index))


class SyncThreads(object):

    def __init__(self, total_threads, over_dict):
        super(SyncThreads, self).__init__()
        self.total_threads, self.over_dict = total_threads, over_dict  # over_dict: if there is a barrier divergence
        self.current_reach_thread = dict()  # key: threads number; value: kernel_codes

    def reach_one(self, threads, kernel_codes):
        threads = str(threads)
        self.current_reach_thread[threads] = kernel_codes
        kernel_codes.set_halt(True)

    def can_continue(self):
        if len(self.current_reach_thread) == self.total_threads:
            for key in self.current_reach_thread:
                self.current_reach_thread[key].set_halt(False)
            self.current_reach_thread.clear()
            return True
        return False


class KernelCodes(object):

    def __init__(self, kernel_codes):
        super(KernelCodes, self).__init__()
        self.codes = [item for item in kernel_codes.split('\n') if len(item) != 0]
        self.label = dict()
        self.calling_code = None
        self.reserved_env = None
        self.father_code = None
        self.is_halt = False
        for index in xrange(len(self.codes)):
            current_item = self.codes[index]
            tmp_res = re.findall(r"; <label>:(\d+)", current_item)
            if len(tmp_res) != 0:
                self.label[str(tmp_res[0])] = index
        self.current_line = 0

    def get_current_execution_code(self):
        start = self
        while start.calling_code is not None:
            start = start.calling_code
        return start

    def set_halt(self, halt_or_not):
        current_execution = self.get_current_execution_code()
        current_execution.is_halt = halt_or_not

    def should_halt(self):
        current_execution = self.get_current_execution_code()
        return current_execution.is_halt

    def prepared_launch_function(self, current_env, other_codes, arguments):
        current_execution = self.get_current_execution_code()
        current_execution.calling_code = other_codes
        other_codes.father_code = current_execution
        tmp_env = Environment()
        tmp_env.binding_value(current_env.env)
        current_env.binding_value(arguments)
        current_execution.reserved_env = tmp_env

    def restore_after_execution_function(self, current_env):
        current_execution = self.get_current_execution_code()
        current_father = current_execution.father_code
        if current_father is None:
            return
        current_env.binding_value(current_father.reserved_env.env)
        current_father.calling_code = None
        current_father.reserved_env = None

    def get_label_by_mark(self, mark):
        current_execution = self.get_current_execution_code()
        return current_execution.label[str(mark)]

    def get_current_statement_and_set_next(self):
        current_execution = self.get_current_execution_code()
        result_stmt = current_execution.codes[current_execution.current_line]
        current_execution.current_line += 1
        return result_stmt

    def get_current_statement(self):
        current_execution = self.get_current_execution_code()
        return current_execution.codes[current_execution.current_line]

    def set_next_statement(self, nxt):
        current_execution = self.get_current_execution_code()
        current_execution.current_line = nxt

    def get_current_line(self):
        current_execution = self.get_current_execution_code()
        return current_execution.current_line

    def is_over(self):
        return len(self.codes) <= self.current_line


class Function(object):

    def __init__(self, target_codes, func_name, argument_lst, type_lst):
        super(Function, self).__init__()
        self.argument_lst = argument_lst
        self.type_lst = type_lst
        self.function_name = func_name
        self.raw_codes = target_codes

    @staticmethod
    def read_function_from_file(target_file, target_env):
        content = open(target_file, 'r').read()
        content = re.sub(r'call void @llvm\.\w+\.\w+\([^\n]*[\n]', "\n", content)
        function_pattern = r"define([^@]*)(?P<function_name>[@|\w]+)\((?P<argument>[^)]+)\)([^{]*){(?P<body>[^}]+)}"
        function_pattern = re.compile(function_pattern, re.DOTALL)
        for single_function in function_pattern.finditer(content):
            function_name = single_function.group('function_name')
            argument = single_function.group('argument')
            argument = [item.strip() for item in argument.split(',') if len(item.strip()) != 0]
            body = single_function.group('body')
            argument_lst = [item.split(' ') for item in argument]
            type_lst = [item[0] for item in argument_lst]
            argument_lst = [item[1] for item in argument_lst]
            target_function = Function(body, function_name, argument_lst, type_lst)
            target_env.add_value(function_name, target_function)


class Environment(object):

    def __init__(self):
        super(Environment, self).__init__()
        self.env = dict()

    def add_value(self, key, value):
        self.env[key] = value

    def remove_value(self, key):
        self.env.pop(key)

    def get_value(self, key):
        if key not in self.env:
            return None
        return self.env[key]

    def binding_value(self, target_dict):
        for key in target_dict:
            self.env[key] = target_dict[key]

    def has_given_key(self, key):
        return key in self.env


class StackSet(object):

    def __init__(self):
        super(StackSet, self).__init__()
        self.list = list()
        self.used_item = dict()

    def size(self):
        return len(self.list)

    def pop(self):
        top_value = self.list[len(self.list) - 1]
        self.used_item.pop(str(top_value))
        self.list.pop()
        return top_value

    def push(self, value):
        if str(value) in self.used_item:
            return
        else:
            self.used_item[str(value)] = True
            self.list.append(value)


if __name__ == '__main__':
    test_block = Block((-1, -1, 0), (2, 1, 1))
    test_thread = Thread((-1, -1, 0), (128, 1, 1))
    num_elements = DataType('i32')
    num_elements.set_value(100)
    global_env_test = Environment()
    shared_memory_test = DataType("[256 x double]*")
    shared_memory_test.set_value("@_ZZL8_vec_sumIdEvPT_S1_iE8row_data")
    global_env_test.add_value("@_ZZL8_vec_sumIdEvPT_S1_iE8row_data", shared_memory_test)
    args = {
        "%v": DataType("double*"),
        "%dim": num_elements,
        "%sum": DataType("double*"),
        "main_memory": "%v"
    }
    args["%v"].set_value("%v")
    from MainProcess import construct_memory_execute_mode
    from MainProcess import parse_target_memory_and_checking_sync
    Function.read_function_from_file("./func.ll", global_env_test)
    raw_code = global_env_test.get_value("@_ZL8_vec_sumIdEvPT_S1_i")
    construct_memory_execute_mode(test_block, test_thread, 100, 256, raw_code.raw_codes, args,
                                  parse_target_memory_and_checking_sync, parse_target_memory_and_checking_sync, global_env_test)
