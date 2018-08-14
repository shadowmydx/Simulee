import re
from matplotlib import pyplot as plt


def parse_item(content_msg):
    pattern = "===============================================================\ncommit comment:.*?==============================================================="
    pattern = re.compile(pattern, re.DOTALL)
    return pattern.findall(content_msg)


def parse_bug_type(bug_item):
    pattern = r"Bug type: (.*)"
    pattern = re.compile(pattern)
    return pattern.findall(bug_item)


def add_count(target_dict, current_arr):
    if len(current_arr) == 1:
        if current_arr[0] not in target_dict:
            target_dict[current_arr[0]] = 1
        else:
            target_dict[current_arr[0]] += 1
        return
    if current_arr[0] not in target_dict:
        target_dict[current_arr[0]] = dict()

    add_count(target_dict[current_arr[0]], current_arr[1:])


def construct_statistic_dict(target_lst):
    target_dict = dict()
    for single_item in target_lst:
        current_arr = single_item.split("::")
        add_count(target_dict, current_arr)
    return target_dict


def count_whole_tree(target_dict):
    if type(target_dict) != type(dict()):
        return target_dict
    all_nodes = 0
    for key in target_dict:
        all_nodes += count_whole_tree(target_dict[key])
    return all_nodes


def calculate_whole_tree(target_dict):
    new_dict = dict()
    for key in target_dict:
        new_dict[key] = count_whole_tree(target_dict[key])
    return new_dict


def count_tree_leaf(target_dict):
    def merge_dict(dict_one, dict_two):
        for single_key in dict_two:
            if single_key not in dict_one:
                dict_one[single_key] = dict_two[single_key]
            else:
                dict_one[single_key] += dict_two[single_key]

    if type(target_dict) != type(dict()):
        return None
    result_dict = dict()
    for key in target_dict:
        current_item = target_dict[key]
        if type(current_item) != type(dict()):
            if key not in result_dict:
                result_dict[key] = current_item
            else:
                result_dict[key] += current_item
        else:
            tmp_result_dict = count_tree_leaf(current_item)
            merge_dict(result_dict, tmp_result_dict)
    return result_dict


def analysis_log_file(file_name):
    content = open(file_name, 'r').read()
    result_lst = parse_item(content)
    result_lst = [parse_bug_type(bug_item)[0] for bug_item in result_lst if len(parse_bug_type(bug_item)) != 0]
    result_dict = construct_statistic_dict(result_lst)
    print result_dict
    result_dict = calculate_whole_tree(result_dict["kernel function execution"])
    draw_statistic_circle_graph(result_dict)
    # draw_statistic_bar_graph(result_dict)
    return result_dict


def count_tree_path(target_dict, result_dict, previous_key):
    if type(target_dict) != type(dict()):
        return None
    for key in target_dict:
        current_item = target_dict[key]
        current_key = '::'.join([item for item in [previous_key, key] if len(item) != 0])
        if type(current_item) == type(dict()):
            count_tree_path(current_item, result_dict, current_key)
        else:
            if current_key not in result_dict:
                result_dict[current_key] = target_dict[key]
            else:
                result_dict[current_key] += target_dict[key]


def analysis_log_files(file_names):
    content = ""
    for file_name in file_names:
        content += open(file_name, 'r').read() + "\n\n"
    result_lst = parse_item(content)
    result_lst = [parse_bug_type(bug_item)[0] for bug_item in result_lst if len(parse_bug_type(bug_item)) != 0]
    result_dict = construct_statistic_dict(result_lst)
    print result_dict
    whole_result_dict = calculate_whole_tree(result_dict)  # count bug distribution
    print whole_result_dict
    real_result_dict = count_tree_leaf(result_dict["kernel function execution"])  # count bug root cause
    print real_result_dict
    # print real_result_dict, sum([real_result_dict[key] for key in real_result_dict])
    new_result_dict = dict()
    count_tree_path(result_dict["host retrieve resource of kernel function"], new_result_dict, "")  # count bug type symptoms/root cause pair
    # count_tree_path(result_dict, new_result_dict, "")
    print new_result_dict
    # draw_statistic_circle_graph(result_dict)
    # draw_statistic_bar_graph(result_dict)
    return result_dict


def draw_statistic_circle_graph(target_dict):
    labels = [key for key in target_dict]
    total_sum = sum([target_dict[key] for key in target_dict])
    sizes = [float(target_dict[key]) / total_sum * 100 for key in target_dict]
    print sizes
    plt.figure(figsize=(6, 9))
    patches, l_text, p_text = plt.pie(sizes, labels=labels,
                                labeldistance=1.1, autopct='%3.1f%%', shadow=False,
                                startangle=90, pctdistance=0.6)
    for t in l_text:
        t.set_size(10)
    for t in p_text:
        t.set_size(10)
    plt.axis('equal')
    plt.legend()
    plt.show()


def draw_statistic_bar_graph(target_dict):
    labels = [key for key in target_dict]
    num_lst = [target_dict[key] for key in target_dict]
    plt.bar(range(len(num_lst)), num_lst, tick_label=labels)
    plt.show()


if __name__ == '__main__':
    # result = analysis_log_file("./report_arrayfire_current_real.log")
    # result = analysis_log_file("./report_current_kaldi_real.log")
    result = analysis_log_files(["./report_mshadow_current_real.log", "./report_arrayfire_current_real.log",
                                 "./report_current_kaldi_real.log", "./report_thundersvm_current_real.log",
                                 "./report_cuda-convnet2.log"])
    # print result
