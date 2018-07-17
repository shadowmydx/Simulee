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
        self.line, self.action, self.block, self.thread = actions


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


class KernelCodes(object):

    def __init__(self, kernel_codes):
        super(KernelCodes, self).__init__()
        self.codes = [item for item in kernel_codes.split('\n') if len(item) != 0]
        self.label = dict()
        for index in xrange(len(self.codes)):
            current_item = self.codes[index]
            tmp_res = re.findall(r"; <label>:(\d+)", current_item)
            if len(tmp_res) != 0:
                self.label[str(tmp_res[0])] = index
        self.current_line = 0

    def get_label_by_mark(self, mark):
        return self.label[str(mark)]

    def get_current_statement_and_set_next(self):
        result_stmt = self.codes[self.current_line]
        self.current_line += 1
        return result_stmt

    def get_current_statement(self):
        return self.codes[self.current_line]

    def set_next_statement(self, nxt):
        self.current_line = nxt

    def is_over(self):
        return len(self.codes) - 1 <= self.current_line


class Environment(object):

    def __init__(self):
        super(Environment, self).__init__()
        self.env = dict()

    def add_value(self, key, value):
        self.env[key] = value

    def remove_value(self, key):
        self.env.pop(key)

    def get_value(self, key):
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
