from functools import reduce
import operator

def parse_answers():
    with open('day6_input.txt', 'r') as reader:
        lines = reader.readlines()

        group_answers = []
        answers = []
        for line in lines:
            if line == '\n':
                group_answers.append(answers)
                answers = []
                continue

            answers.append(line.strip())
        else:
            group_answers.append(answers)

    return group_answers

def part1():
    return sum([len(set(''.join(answers))) for answers in parse_answers()])

def part2():
    return sum([len(reduce(operator.and_, [set(answer) for answer in answers])) for answers in parse_answers()])

print(part1())
print(part2())
