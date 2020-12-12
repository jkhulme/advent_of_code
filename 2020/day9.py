PREAMBLE = 25

def parse_input():
    with open('day9_input.txt', 'r') as reader:
        lines = reader.readlines()

    return [int(line.strip()) for line in lines]

def valid(code, preamble):
    remainders = []
    for number in preamble:
        if code - number == number:
            return True
        if number in remainders:
            return True

        remainders.append(code - number)

    return False


def part1():
    numbers = parse_input()
    for i, number in enumerate(numbers):
        if i < PREAMBLE:
            continue

        if valid(number, numbers[i - PREAMBLE:i]):
            continue

        return number

    return -1

def part2():
    goal = part1()
    numbers = parse_input()

    for i, number in enumerate(numbers):
        for j in range(i + 1, len(numbers)):
            if sum(numbers[i:j]) == goal:
                return min(numbers[i:j]) + max(numbers[i:j])

    return -1

print(part1())
print(part2())
