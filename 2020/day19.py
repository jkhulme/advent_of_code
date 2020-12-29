import re


def parse_input():
    parsed_rules = {}
    strings = []
    parsing_rules = True

    with open('day19_input.txt', 'r') as reader:
        for line in reader.readlines():
            line = line.strip()
            if line == "":
                parsing_rules = False
                continue

            if parsing_rules:
                k, rules = line.split(':')
                rules = rules.replace('"', '').strip()
                if len(rules) == 1:
                    parsed_rules[k] = rules
                    continue
                else:
                    parsed_rules[k] = [rule.strip().split(' ') for rule in rules.split('|')]
            else:
                strings.append(line)

    return parsed_rules, strings

def build_regex(rules, key):
    rule = rules[key]
    if isinstance(rule, str):
        return rule
    elif len(rule) == 1:
        return "(" + "".join([build_regex(rules, r) for r in rule[0]]) + ")"
    else:
        branches = []
        for sub_rule in rule:
            branches.append("".join([build_regex(rules, r) for r in sub_rule]))
        return "(" + "|".join(branches) + ")"

def part1():
    rules, strings = parse_input()
    pattern = "^" + build_regex(rules, "0") + "$"
    return sum([1 for s in strings if re.match(pattern, s)])

print(part1())
