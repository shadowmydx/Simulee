import re


class Thread(object):

    def __init__(self, location, block_dim):
        super(Thread, self).__init__()
        self.x, self.y, self.z = location
        self.limit_x, self.limit_y, self.limit_z = block_dim


class Block(object):

    def __init__(self, location, grid_dim):
        super(Block, self).__init__()
        self.x, self.y, self.z = location
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
        return len(self.codes) - 1 == self.current_line


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
