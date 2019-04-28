import re
from DetectBug import parse_function
from collections import OrderedDict


class BranchInformation(object):
    def __init__(self, raw_codes):
        self.from_true = 'True'
        self.from_false = 'False'
        self.label_boolean = '%label'
        self.raw_codes = raw_codes
        self.branch_map = OrderedDict()  # key: label name value: label that can go to
        self.label_dict = OrderedDict()  # key: label name value: branch name (label: branch1&&branch2, then can be access)
        self.back_order_map = OrderedDict()  # reverse of branch map
        self.statement_to_label = OrderedDict()
        self.label_to_statement = OrderedDict()
        self.main_path_node = set()
        self.last_label = None
        self.new_create_label = None
        self.construct_statement_and_label()
        self.construct_label_dict()
        self.construct_branch_map()
        self.construct_back_order_map()
        self.find_all_main_path_node()

    def generate_path_to_end(self, start_node):
        visited_node = set()
        current_node = start_node
        path = list()
        while current_node != self.last_label:
            visited_node.add(current_node)
            path.append(current_node)
            for single_node in self.branch_map[current_node]:
                if single_node not in visited_node:
                    current_node = single_node
                    break
        path.append(self.last_label)
        return path

    def get_next_in_common(self, node_set):
        start_node_one, start_node_two = list(node_set)
        path_one = self.generate_path_to_end(start_node_one)
        path_two = self.generate_path_to_end(start_node_two)
        path_in_one = set(path_one)
        for single_node in path_two:
            if single_node in path_in_one:
                return single_node
        print "ERROR!! In Get Next In Common"
        return None  # should not be here.

    def find_all_main_path_node(self):
        current_main_node = '0'
        while current_main_node != self.last_label:
            self.main_path_node.add(current_main_node)
            if len(self.branch_map[current_main_node]) == 1:
                current_main_node = list(self.branch_map[current_main_node])[0]
            else:
                current_main_node = self.get_next_in_common(self.branch_map[current_main_node])
        self.main_path_node.add(current_main_node)

    def construct_statement_and_label(self):
        raw_codes = self.raw_codes
        current_label = '0'  # start with 0
        for each_line in raw_codes:
            each_line = each_line.strip()
            label = self.parse_label(each_line)
            if current_label not in self.label_to_statement:
                self.label_to_statement[current_label] = list()
            if label is not None:
                current_label = label
                if current_label not in self.label_to_statement:
                    self.label_to_statement[current_label] = [each_line]
            else:
                self.statement_to_label[each_line] = current_label
                self.label_to_statement[current_label].append(each_line)

    def construct_normal_repair_patch(self, target_label):
        statement_lst = self.label_to_statement[target_label]
        statement_lst.insert(1, "call void @__syncthreads()")
        for each_label in self.label_to_statement:
            current_statement = self.label_to_statement[each_label]
            print '\n'.join(current_statement)
            print
            print

    def find_nearest_common(self, target_label):
        previous_common = target_label
        while previous_common not in self.main_path_node:
            previous_common = list(self.back_order_map[previous_common])[0]
        next_common = target_label
        while next_common not in self.main_path_node:
            next_common = list(self.branch_map[next_common])[0]
        return previous_common, next_common

    def split_label(self, target_stmt, target_label):
        new_label = self.new_create_label
        self.new_create_label = str(int(self.new_create_label) + 1)
        statement_lst = self.label_to_statement[target_label]
        split_index = statement_lst.index(target_stmt)
        pre_lst = statement_lst[: split_index]
        new_lst = ["; <label>:(num)".replace("(num)", new_label)]
        new_lst += statement_lst[split_index:]
        pre_lst.append("br label %" + new_label)
        self.label_to_statement[target_label] = pre_lst
        self.label_to_statement[new_label] = new_lst
        for statement in new_lst:
            self.statement_to_label[statement] = new_label
        self.branch_map[new_label] = self.branch_map[target_label]
        self.branch_map[target_label] = {new_label}
        self.back_order_map[new_label] = {target_label}
        for item in self.branch_map[new_label]:
            self.back_order_map[item].remove(target_label)
            self.back_order_map[item].add(new_label)
        return new_label

    def repair_pair_statements(self, statement_one, statement_two):
        label_one = self.statement_to_label[statement_one]
        label_two = self.statement_to_label[statement_two]
        if label_one == label_two:
            label_two = self.split_label(statement_two, label_two)
        if label_one in self.main_path_node or label_two in self.main_path_node:
            target_label = label_one if label_one in self.main_path_node else label_two
            self.construct_normal_repair_patch(target_label)
            return
        common_start_one, common_end_one = self.find_nearest_common(label_one)
        common_start_two, common_end_two = self.find_nearest_common(label_two)
        if common_start_one != common_start_two:
            target_label = common_end_two if int(common_end_two) < int(common_end_one) else common_end_one
            self.construct_normal_repair_patch(target_label)
            return
        condition_label_dict = self.parse_condition_for_each_label(common_start_one, common_end_one)
        new_structure = self.generate_new_structure(condition_label_dict)
        self.construct_repair_patch(label_one, label_two, common_start_one, new_structure)

    def construct_repair_patch(self, label_one, label_two, start_label, new_structure):
        should_add = False
        already_added = False
        used_label = set()
        barrier_label = 0
        for each_label in self.label_to_statement:
            if each_label == start_label:
                break  # assume: order dict
            used_label.add(each_label)
            statement_lst = self.label_to_statement[each_label]
            print '\n'.join(statement_lst)
            print
            print
        for each_label in new_structure:
            used_label.add(each_label)
            statement_lst = self.label_to_statement[each_label]
            if should_add and not already_added:
                statement_lst.insert(1, "call void @__syncthreads(), " + str(barrier_label))
                barrier_label += 1
                should_add = False
                # already_added = True
            print '\n'.join(statement_lst)
            print
            print
            if should_add is False and (label_one == each_label or label_two == each_label):
                should_add = True
        for each_label in self.label_to_statement:
            if each_label not in used_label:
                statement_lst = self.label_to_statement[each_label]
                print '\n'.join(statement_lst)
                print
                print

    def add_boolean_value(self, target_label):
        not_logic_dict = {
            'eq': 'ne',
            'ne': 'eq',
            'gt': 'le',
            'le': 'gt',
            'ge': 'lt',
            'lt': 'ge'
        }
        statement_lst = self.label_to_statement[target_label]
        for index in xrange(len(statement_lst)):
            current_statement = statement_lst[index]
            boolean_value = self.parse_boolean_from_br(current_statement)
            if len(boolean_value) != 0:
                boolean_value = boolean_value[0]
                icmp_statement = statement_lst[index - 1]  # careful!!! assumption here, index - 1 is an icmp ir
                for operator in not_logic_dict:
                    if icmp_statement.find(operator) != -1:
                        icmp_statement = icmp_statement.replace(operator, not_logic_dict[operator])
                        break
                boolean_value_statement = self.label_boolean + target_label + " = load i1 " + str(boolean_value)
                boolean_value_statement_not = self.label_boolean + target_label + "not = " + icmp_statement[
                                                                                             icmp_statement.find(
                                                                                                 "=") + 1:].strip()
                statement_lst.insert(index, boolean_value_statement_not)
                statement_lst.insert(index, boolean_value_statement)
                # print statement_lst
                return self.label_boolean + target_label, self.label_boolean + target_label + "not"
                # statement_lst[index + 1] = "br label %" + str(jump_label)

    def generate_new_structure(self, condition_label_dict):
        result_lst = list()
        added_label = dict()
        start_label = str(int(self.new_create_label) + 1)
        for each_label in condition_label_dict:
            for boolean_value in condition_label_dict[each_label]:
                target_label = boolean_value[0]
                if target_label not in added_label:
                    added_label[target_label] = self.add_boolean_value(target_label)
        self.change_target_label_br(next(iter(condition_label_dict)), start_label)
        result_lst.append(next(iter(condition_label_dict)))
        for each_label in condition_label_dict:
            if len(condition_label_dict[each_label]) != 0:
                all_conditions = list(condition_label_dict[each_label])
                first_condition = all_conditions[0]
                variable_name = self.label_boolean + start_label
                statement_lst = ["; <label>:" + start_label]
                first_condition = variable_name + " = load i1 " + added_label[first_condition[0]][
                    0 if first_condition[1] == 'True' else 1]
                statement_lst.append(first_condition)
                for index in xrange(1, len(all_conditions)):
                    current_condition = all_conditions[index]
                    first_condition = variable_name + " = and i1 " + variable_name + ", " + \
                                      added_label[current_condition[0]][0 if current_condition[1] == 'True' else 1]
                    statement_lst.append(first_condition)
                statement_lst.append(
                    "br i1 " + variable_name + ", label %" + each_label + ", label %" + str(int(start_label) + 1))
                self.label_to_statement[start_label] = statement_lst
                result_lst.append(start_label)
                start_label = str(int(start_label) + 1)
                self.change_target_label_br(each_label, start_label)
                result_lst.append(each_label)
        statement_lst = list(["; <label>:" + start_label])
        statement_lst.append("br label %" + next(reversed(condition_label_dict)))
        self.label_to_statement[start_label] = statement_lst
        result_lst.append(start_label)
        result_lst.append(next(iter(reversed(condition_label_dict))))
        return result_lst

    def change_target_label_br(self, each_label, new_label):
        statement_lst = self.label_to_statement[each_label]
        for index in xrange(len(statement_lst)):
            current_statement = statement_lst[index]
            if current_statement.find("br") != -1:  # should consider loop in the future!
                target_label = self.parse_from_br(current_statement)
                if len(target_label) == 1 and int(target_label[0]) <= int(each_label) <= int(self.last_label):
                    continue  # ignore loop, adding label should not contain loop
                statement_lst[index] = "br label %" + new_label

    def construct_back_order_map(self):
        for single_label in self.branch_map:
            if single_label not in self.back_order_map:
                self.back_order_map[single_label] = set()
            for next_label in self.branch_map[single_label]:
                if next_label not in self.back_order_map:
                    self.back_order_map[next_label] = set()
                self.back_order_map[next_label].add(single_label)

    def parse_condition_topology(self, start_node, end_node, result_dict):
        topology_lst = list()
        self.topology_sort(start_node, end_node, topology_lst, dict())
        topology_lst.reverse()
        for current_node in topology_lst:
            if current_node in self.label_dict:
                result_dict[current_node] = set()
                result_dict[current_node].add(self.label_dict[current_node])
            if len(self.back_order_map[current_node]) > 1:
                previous_condition = list(self.back_order_map[current_node])
                total_condition = set(list(result_dict[previous_condition[0]]))  # deep copy
                has_condition = False
                if current_node in result_dict:
                    has_condition = True
                for each_condition in previous_condition:
                    if has_condition:
                        if each_condition == self.label_dict[current_node][0]:
                            total_condition &= (result_dict[each_condition] | result_dict[current_node])
                    total_condition &= result_dict[each_condition]
                result_dict[current_node] = total_condition
            else:
                previous_condition = list(self.back_order_map[current_node])
                if len(previous_condition) != 0:
                    if previous_condition[0] not in result_dict:
                        continue
                    if current_node in result_dict:
                        result_dict[current_node] |= result_dict[
                            previous_condition[0]]  # only one previous and in label dict
                    else:
                        result_dict[current_node] = result_dict[previous_condition[0]]

    def topology_sort(self, start_node, end_node, topology_lst, visited_node):
        if start_node in visited_node:
            return
        visited_node[start_node] = True
        if start_node != end_node:
            for next_node in self.branch_map[start_node]:
                self.topology_sort(next_node, end_node, topology_lst, visited_node)
        topology_lst.append(start_node)

    def parse_condition_for_each_label(self, start_main_node, end_main_node):
        result_dict = OrderedDict()
        result_dict[start_main_node] = set()
        self.parse_condition_topology(start_main_node, end_main_node, result_dict)
        return result_dict

    def construct_branch_map(self):
        raw_codes = self.raw_codes
        current_label = '0'  # start with 0
        previous_label = None
        for each_line in raw_codes:
            each_line = each_line.strip()
            label = self.parse_label(each_line)
            if label is not None:
                current_label = label
                if previous_label is not None:
                    statement_lst = self.label_to_statement[previous_label]
                    statement_lst.append("br label %" + str(current_label))
                    self.branch_map[previous_label].add(current_label)
                    previous_label = None
            br_labels = self.parse_from_br(each_line)
            if current_label not in self.branch_map:
                self.branch_map[current_label] = set()
            for single_label in br_labels:
                if int(single_label) > int(current_label):
                    self.branch_map[current_label].add(single_label)  # ignore loop label.
                else:
                    previous_label = current_label
        self.last_label = current_label
        self.new_create_label = str(int(current_label) + 1)

    def construct_label_dict(self):
        raw_codes = self.raw_codes
        current_label = '0'  # start with 0
        for each_line in raw_codes:
            each_line = each_line.strip()
            label = self.parse_label(each_line)
            if label is not None:
                current_label = label
            br_labels = self.parse_from_br(each_line)
            is_branch = False
            if len(br_labels) < 2:
                continue
            for single_label in br_labels:
                if int(single_label) <= int(current_label):
                    is_branch = False
                    break
                else:
                    is_branch = True
            if is_branch:
                self.label_dict[br_labels[0]] = current_label, self.from_true
                self.label_dict[br_labels[1]] = current_label, self.from_false

    @staticmethod
    def parse_from_br(single_line):
        br_index = single_line.find("br")
        if br_index == -1:
            return list()
        single_line = single_line[3:]
        arguments = single_line.split(",")
        return [re.compile(r"\d+").findall(item)[0] for item in arguments if item.find("label") != -1]

    @staticmethod
    def parse_boolean_from_br(single_line):
        br_index = single_line.find("br")
        if br_index == -1:
            return list()
        single_line = single_line[3:]
        arguments = single_line.split(",")[: -1]
        return [re.compile(r"%\d+").findall(item)[0] for item in arguments if item.find("label") == -1]

    @staticmethod
    def parse_label(single_line):
        label_pattern = re.compile(r"; <label>:(?P<label_number>\d+)")
        target_label = label_pattern.findall(single_line)
        return target_label[0] if len(target_label) != 0 else None


def test():
    global_env = parse_function("./read_write_test.ll")
    target_function = global_env.get_value("@_Z13device_globalPji")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    # print branch.branch_map
    branch.repair_pair_statements("%27 = load i32* %26, align 4, !dbg !161",
                                  "store i32 %16, i32* %20, align 4, !dbg !158")
    # target_codes = KernelCodes(target_function)
    # print "test"


def test_arrayfire():
    global_env = parse_function("./arrayfire-repair/reduce.ll")
    target_function = global_env.get_value("@_Z11warp_reducePd")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    branch.repair_pair_statements("%24 = load double* %23, align 8, !dbg !31",
                                  "store double %28, double* %30, align 8, !dbg !33")
    print "here"


if __name__ == "__main__":
    test_arrayfire()
    # test()
