import math


def parse_input():
    with open('day10_input.txt', 'r') as reader:
        lines = reader.readlines()

    return [int(line.strip()) for line in lines]

def part1():
    adaptors = parse_input()
    adaptors.sort()

    diff_1 = 1
    diff_3 = 1
    for i in range(1, len(adaptors)):
        difference = adaptors[i] - adaptors[i - 1]
        if difference == 1:
            diff_1 += 1
        if difference == 3:
            diff_3 += 1

    return diff_1 * diff_3

def count_branches(adaptors, initial_adaptor):
    return [adaptor for adaptor in adaptors[1:] if adaptor - initial_adaptor <= 3]

def part2():
    adaptors = parse_input()
    adaptors.sort()

    adaptor_combos = []
    for i, adaptor in enumerate(adaptors[:-1]):
        adaptor_combos.insert(0, (adaptor, count_branches(adaptors[i:], adaptor)))

    branches = {adaptors[-1]: 1}
    for adaptor, combo in adaptor_combos:
        branches[adaptor] = sum([branches[c] for c in combo])

    return branches[adaptors[0]]


print(part1())
print(part2())
