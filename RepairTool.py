import re
from DetectBug import parse_function
from collections import OrderedDict


class BranchInformation(object):
    def __init__(self, raw_codes):
        self.from_true = 'True'
        self.from_false = 'False'
        self.label_boolean = '%label'
        self.raw_codes = raw_codes
        self.label_order_lst = list()
        self.branch_map = OrderedDict()  # key: label name value: label that can go to
        self.label_dict = OrderedDict()  # key: label name value: branch name (label: branch1&&branch2, then can be access)
        self.back_order_map = OrderedDict()  # reverse of branch map
        self.statement_to_label = OrderedDict()
        self.label_to_statement = OrderedDict()
        self.main_path_node = set()
        self.last_label = None
        self.new_create_label = None
        self.new_initial_variable = set()
        self.boolean_pattern = "(var) = alloca i1, align 4"
        self.construct_statement_and_label()
        self.construct_label_dict()
        self.construct_branch_map()
        self.construct_back_order_map()
        self.find_all_main_path_node()

    def repair_redundant_barrier_function(self, target_barrier):
        new_code_lst = list()
        for each_line in self.raw_codes:
            if each_line != target_barrier:
                new_code_lst.append(each_line)
        print "\n".join(new_code_lst)
        return "\n".join(new_code_lst)

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
                self.label_order_lst.append(current_label)
            if label is not None:
                current_label = label
                if current_label not in self.label_to_statement:
                    self.label_to_statement[current_label] = [each_line]
                    self.label_order_lst.append(current_label)
            else:
                self.statement_to_label[each_line] = current_label
                self.label_to_statement[current_label].append(each_line)

    def construct_normal_repair_patch(self, target_label_lst):
        content_str = ""
        for target_label in target_label_lst:
            statement_lst = self.label_to_statement[target_label]
            if statement_lst[1].find("void @__syncthreads()") == -1:
                statement_lst.insert(1, "call void @__syncthreads()")
        for each_label in self.label_to_statement:
            current_statement = self.label_to_statement[each_label]
            print '\n'.join(current_statement)
            print
            print
            content_str += '\n'.join(current_statement) + '\n\n'
        return content_str

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
        new_index = self.label_order_lst.index(target_label) + 1
        self.label_order_lst.insert(new_index, new_label)
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
            return self.construct_normal_repair_patch([target_label, target_label])
        common_start_one, common_end_one = self.find_nearest_common(label_one)
        common_start_two, common_end_two = self.find_nearest_common(label_two)
        if common_start_one != common_start_two:
            target_label_lst = [common_end_two, common_end_one] if int(common_end_two) < int(common_end_one) else [
                common_end_one, common_end_two]
            return self.construct_normal_repair_patch(target_label_lst)
        condition_label_dict = self.parse_condition_for_each_label(common_start_one, common_end_one)
        new_structure = self.generate_new_structure(condition_label_dict)
        return self.construct_repair_patch(label_one, label_two, common_start_one, new_structure)

    def add_new_initial_var(self):
        statement_lst = self.label_to_statement["0"]
        for variable in self.new_initial_variable:
            statement_lst.insert(0, self.boolean_pattern.replace("(var)", variable))

    def construct_repair_patch(self, label_one, label_two, start_label, new_structure):
        content_str = ""
        should_add = False
        already_added = False
        used_label = set()
        barrier_label = 0
        self.add_new_initial_var()
        # for each_label in self.label_to_statement:
        for each_label in self.label_order_lst:
            if each_label == start_label:
                break  # assume: order dict
            used_label.add(each_label)
            statement_lst = self.label_to_statement[each_label]
            print '\n'.join(statement_lst)
            print
            print
            content_str += '\n'.join(statement_lst) + "\n\n"
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
            content_str += '\n'.join(statement_lst) + "\n\n"
            if should_add is False and (label_one == each_label or label_two == each_label):
                should_add = True

        # for each_label in self.label_to_statement:
        for each_label in self.label_order_lst:
            if each_label not in used_label:
                statement_lst = self.label_to_statement[each_label]
                print '\n'.join(statement_lst)
                print
                print
                content_str += '\n'.join(statement_lst) + "\n\n"
        return content_str

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
        for key in added_label:
            self.new_initial_variable.add(added_label[key][0])
            self.new_initial_variable.add(added_label[key][1])
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
                if previous_condition[0] not in result_dict:
                    continue
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
                    if statement_lst[-1] != "br label %" + str(current_label):
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
        self.new_create_label = str(max([int(label) for label in self.label_to_statement]) + 1)

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


def test_thundersvm():
    global_env = parse_function("./thundersvm-repair/smo_kernel.ll")
    target_function = global_env.get_value("@_Z19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    branch.repair_pair_statements("store float %66, float* %70, align 4, !dbg !114",
                                  "%79 = call i32 @_Z13get_block_minPKfPi(float* %77, i32* %78), !dbg !118")
    print "here"


def test_kaldi_add_diag():
    # global_env = parse_function("./kaldi-repair/_add_diag_mat_no.ll")
    # target_function = global_env.get_value("@_Z17_add_diag_mat_matdPdiPKdiiiS1_iid")
    # branch = BranchInformation(
    #     [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    # branch.repair_pair_statements("%93 = load double* %92, align 8, !dbg !69", "store double %66, double* %69, align 8, !dbg !56")
    # print 100 * "+"
    global_env = parse_function("./kaldi-repair/_add_diag_mat_repair.ll")
    target_function = global_env.get_value("@_Z17_add_diag_mat_matdPdiPKdiiiS1_iid")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    branch.repair_pair_statements("%93 = load double* %92, align 8, !dbg !69",
                                  "store double %100, double* %98, align 8, !dbg !72")
    print "here"


def test_arrayfire_scan_dim():
    global_env = parse_function("./arrayfire-repair/scan_dim.ll")
    target_function = global_env.get_value("@_Z15scan_dim_kerneljjjj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    branch.repair_pair_statements("%87 = load double* %86, align 8, !dbg !78",
                                  "store double %47, double* %50, align 8, !dbg !63")
    print "here"


def test_arrayfire_compute_val_homography():
    global_env = parse_function("./arrayfire-repair/homography.ll")
    target_function = global_env.get_value("@_Z21computeEvalHomographyjjjf")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    branch.repair_pair_statements("%64 = load i32* %63, align 4, !dbg !52",
                                  "store i32 %25, i32* %28, align 4, !dbg !41")
    print "here"


def test_arrayfire_scan_dim_nofinal_kernel():
    global_env = parse_function("./arrayfire-repair/scan_dim_by_key_impl.ll")
    target_function = global_env.get_value("@_Z24scan_dim_nonfinal_kerneljjj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%62 = load i8* %61, align 1, !dbg !80",
                                            "store i8 %113, i8* %116, align 1, !dbg !94")
    content = "define void @_Z24scan_dim_nonfinal_kerneljjj(i32 %blocks_x, i32 %blocks_y, i32 %lim) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/scan_dim_by_key_impl-repair.ll", content)


def test_arrayfire_scan_nofinal_kernel():
    global_env = parse_function("./arrayfire-repair/scan_first_by_key_impl.ll")
    target_function = global_env.get_value("@_Z20scan_nonfinal_kerneljjj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%80 = load i8* %79, align 1, !dbg !91",
                                            "store i8 %128, i8* %131, align 1, !dbg !105")
    content = "define void @_Z20scan_nonfinal_kerneljjj(i32 %blocks_x, i32 %blocks_y, i32 %lim) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/scan_first_by_key_impl-repair.ll", content)


def test_arrayfire_hamming_matcher_unroll_1():
    global_env = parse_function("./arrayfire-repair/hamming1.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_j")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%148 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 0), align 4, !dbg !78",
        "store i32 %26, i32* %29, align 4, !dbg !43")
    content = "define void @_Z22hamming_matcher_unrollPjS_j(i32* %out_idx, i32* %out_dist, i32 %max_dist) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming1-repair.ll", content)


def test_arrayfire_hamming_matcher_1():
    global_env = parse_function("./arrayfire-repair/hamming2.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%149 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 0), align 4, !dbg !81",
        "store i32 %27, i32* %30, align 4, !dbg !44")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming2-repair.ll", content)


def test_arrayfire_hamming_matcher_2():
    global_env = parse_function("./arrayfire-repair/hamming3.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%204 = load i32* %203, align 4, !dbg !88",
        "store i32 %159, i32* %162, align 4, !dbg !79")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-first.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming3-first.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%204 = load i32* %203, align 4, !dbg !88",
        "store i32 %187, i32* %190, align 4, !dbg !84")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-second.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming3-second.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%148 = load i32* %147, align 4, !dbg !78",
        "store i32 %131, i32* %134, align 4, !dbg !74")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-third.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming3-third.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%176 = load i32* %175, align 4, !dbg !83",
        "store i32 %187, i32* %190, align 4, !dbg !84")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-4th.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming3-4th.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%215 = load i32* %214, align 4, !dbg !89",
        "store i32 %215, i32* %218, align 4, !dbg !89")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-5th.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming3-5th.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%187 = load i32* %186, align 4, !dbg !84",
        "store i32 %187, i32* %190, align 4, !dbg !84")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-6th.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming3-6th.ll")
    target_function = global_env.get_value("@_Z15hamming_matcherPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%159 = load i32* %158, align 4, !dbg !79",
        "store i32 %159, i32* %162, align 4, !dbg !79")
    content = "define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming3-7th.ll", content)


def test_arrayfire_hamming_matcher_unroll_2():
    global_env = parse_function("./arrayfire-repair/hamming4.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%204 = load i32* %203, align 4, !dbg !88",
        "store i32 %159, i32* %162, align 4, !dbg !79")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-first.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming4-first.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%204 = load i32* %203, align 4, !dbg !88",
        "store i32 %187, i32* %190, align 4, !dbg !84")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-second.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming4-second.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%148 = load i32* %147, align 4, !dbg !78",
        "store i32 %131, i32* %134, align 4, !dbg !74")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-third.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming4-third.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%176 = load i32* %175, align 4, !dbg !83",
        "store i32 %187, i32* %190, align 4, !dbg !84")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-4th.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming4-4th.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%215 = load i32* %214, align 4, !dbg !89",
        "store i32 %215, i32* %218, align 4, !dbg !89")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-5th.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming4-5th.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%187 = load i32* %186, align 4, !dbg !84",
        "store i32 %187, i32* %190, align 4, !dbg !84")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-6th.ll", content)

    global_env = parse_function("./arrayfire-repair/hamming4-6th.ll")
    target_function = global_env.get_value("@_Z22hamming_matcher_unrollPjS_jj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%159 = load i32* %158, align 4, !dbg !79",
        "store i32 %159, i32* %162, align 4, !dbg !79")
    content = "define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/hamming4-7th.ll", content)


def test_arrayfire_JacobiSVD():
    global_env = parse_function("./arrayfire-repair/JacobiSVD.ll")
    target_function = global_env.get_value("@_Z9JacobiSVDPiS_ii")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%53 = load i32* %52, align 4, !dbg !65",
                                            "store i32 %140, i32* %144, align 4, !dbg !89")
    content = "define void @_Z9JacobiSVDPiS_ii(i32* %S, i32* %V, i32 %m, i32 %n) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./arrayfire-repair/JacobiSVD-first.ll", content)

    global_env = parse_function("./arrayfire-repair/JacobiSVD-first.ll")
    target_function = global_env.get_value("@_Z9JacobiSVDPiS_ii")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%58 = load i32* %57, align 4, !dbg !65",
                                            "store i32 %145, i32* %149, align 4, !dbg !90")
    content = "define void @_Z9JacobiSVDPiS_ii(i32* %S, i32* %V, i32 %m, i32 %n) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./arrayfire-repair/JacobiSVD-second.ll", content)
    print "here"


def test_arrayfire_descriptor():
    global_env = parse_function("./arrayfire-repair/Descriptor1-delete.ll")
    target_function = global_env.get_value("@_Z17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffi")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%71 = load float* %70, align 4, !dbg !90",
                                            "store float 0.000000e+00, float* %52, align 4, !dbg !82")
    content = "define void @_Z17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffi(float* %desc_out, i32 %desc_len, i32 %histsz, float* %x_in, float* %y_in, i32* %layer_in, float* %response_in, float* %size_in, float* %ori_in, i32 %total_feat, i32 %d, i32 %n, float %scale, float %sigma, i32 %n_layers) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./arrayfire-repair/Descriptor1-first.ll", content)

    global_env = parse_function("./arrayfire-repair/Descriptor1-first.ll")
    target_function = global_env.get_value("@_Z17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffi")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("store float %77, float* %75, align 4, !dbg !90",
                                            "store float 0.000000e+00, float* %52, align 4, !dbg !82")
    content = "define void @_Z17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffi(float* %desc_out, i32 %desc_len, i32 %histsz, float* %x_in, float* %y_in, i32* %layer_in, float* %response_in, float* %size_in, float* %ori_in, i32 %total_feat, i32 %d, i32 %n, float %scale, float %sigma, i32 %n_layers) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./arrayfire-repair/Descriptor1-second.ll", content)
    print "here"


def test_arrayfire_select_matches_1():
    global_env = parse_function("./arrayfire-repair/select_matches-delete.ll")
    target_function = global_env.get_value("@_Z14select_matchesPKjPKijji")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements(
        "%31 = load i32* %30, align 4, !dbg !45",
        "store i32 %39, i32* %42, align 4, !dbg !47")
    content = "define void @_Z14select_matchesPKjPKijji(i32* %in_idx, i32* %in_dist, i32 %nfeat, i32 %nelem, i32 %max_dist) uwtable noinline {\n" + content + "\n}"
    write_patch_to_file("./arrayfire-repair/select_matches-repair.ll", content)


def test_gklee_barrier1():
    global_env = parse_function("./gklee-test-repair/barrier1-delete.ll")
    target_function = global_env.get_value("@_Z2dlPi")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%34 = load i32* %33, align 4, !dbg !24",
                                            "store i32 %51, i32* %55, align 4, !dbg !27")
    content = "define void @_Z2dlPi(i32* %in) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./gklee-test-repair/barrier1-first.ll", content)
    global_env = parse_function("./gklee-test-repair/barrier1-first.ll")
    target_function = global_env.get_value("@_Z2dlPi")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%46 = load i32* %45, align 4, !dbg !26",
                                            "store i32 %51, i32* %55, align 4, !dbg !27")
    content = "define void @_Z2dlPi(i32* %in) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./gklee-test-repair/barrier1-second.ll", content)
    global_env = parse_function("./gklee-test-repair/barrier1-second.ll")
    target_function = global_env.get_value("@_Z2dlPi")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%34 = load i32* %33, align 4, !dbg !24",
                                            "store i32 %19, i32* %17, align 4, !dbg !19")
    content = "define void @_Z2dlPi(i32* %in) uwtable noinline {\n" + content + "}"
    write_patch_to_file("./gklee-test-repair/barrier1-repair.ll", content)
    print "here"


def test_arrayfire_warp_reduce1():
    global_env = parse_function("./arrayfire-repair/reduce1.ll")
    target_function = global_env.get_value("@_Z11warp_reducePiPj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_pair_statements("%23 = load i32* %22, align 4, !dbg !30",
                                            "store i32 %36, i32* %40, align 4, !dbg !36")
    content = 'define void @_Z11warp_reducePiPj(i32* %s_ptr, i32* %s_idx) nounwind uwtable section "__device__" {' + content + "}\n"
    write_patch_to_file("./arrayfire-repair/reduce1-repair.ll", content)


def test_arrayfire_compute_median():
    global_env = parse_function("./arrayfire-repair/computeMedian.ll")
    target_function = global_env.get_value("@_Z13computeMedianj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_redundant_barrier_function("call void @__syncthreads(), !dbg !31")
    content = 'define void @_Z13computeMedianj(i32 %iterations) uwtable noinline {' + content + "}\n"
    write_patch_to_file("./arrayfire-repair/computeMedian-repair.ll", content)


def test_arrayfire_harris_response():
    global_env = parse_function("./arrayfire-repair/harris_response.ll")
    target_function = global_env.get_value("@_Z15harris_responsePfS_PKfS1_S1_jS_jfj")
    branch = BranchInformation(
        [item.strip() for item in target_function.raw_codes.split("\n") if len(item.strip()) != 0])
    content = branch.repair_redundant_barrier_function("call void @__syncthreads(), !dbg !110")
    content = 'define void @_Z15harris_responsePfS_PKfS1_S1_jS_jfj(float* %score_out, float* %size_out, float* %x_in, float* %y_in, float* %scl_in, i32 %total_feat, float* %image_ptr, i32 %block_size, float %k_thr, i32 %patch_size) uwtable noinline {' + content + "}\n"
    write_patch_to_file("./arrayfire-repair/harris_response-repair.ll", content)


def write_patch_to_file(file_path, content):
    with open(file_path, 'w') as f:
        f.write(content)


if __name__ == "__main__":
    from time import time

    start_time = time()
    test_arrayfire_compute_median()
    # test_arrayfire_descriptor()
    # test_arrayfire_select_matches_1()
    # test_arrayfire_hamming_matcher_unroll_2()
    # test_arrayfire_hamming_matcher_2()
    # test_arrayfire_descriptor()
    # test_arrayfire_warp_reduce1()
    # test_arrayfire_JacobiSVD()
    # test_arrayfire_hamming_matcher_1()
    # test_arrayfire_hamming_matcher_unroll_1()
    # test_arrayfire_scan_nofinal_kernel()
    # test_arrayfire_scan_dim_nofinal_kernel()
    # test_gklee_barrier1()
    # test_arrayfire_scan_dim()
    # test_kaldi_add_diag()
    # test_thundersvm()
    # test_arrayfire()
    # test_arrayfire_compute_val_homography()
    # test()
    print str(time() - start_time)
