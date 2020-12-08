def parse_input():
    # This is gank, there must be a nicer way to do this
    with open('day8_input.txt', 'r') as reader:
        instructions = [line.strip().split(' ') for line in reader.readlines()]

    return instructions

def run_program(instructions):
    accumulator = 0
    i = 0
    ran_instructions = []

    while i not in ran_instructions:
        if i >= len(instructions):
            break

        instruction = instructions[i]
        ran_instructions.append(i)

        if instruction[0] == 'acc':
            accumulator += int(instruction[1])
        if instruction[0] == 'jmp':
            i += int(instruction[1])
        else: # noop
            i += 1

    return accumulator, max(ran_instructions)


def part1():
    instructions = parse_input()
    return run_program(instructions)[0]

def part2():
    instructions = parse_input()
    instruction_swap = {'nop': 'jmp', 'jmp': 'nop'}

    for i, instruction in enumerate(instructions):
        if instruction[0] == 'acc':
            continue

        instructions[i][0] = instruction_swap[instructions[i][0]]

        accumulator, max_instruction = run_program(instructions)
        if max_instruction == len(instructions) - 1:
            return accumulator

        instructions[i][0] = instruction_swap[instructions[i][0]]

    return -1

print(part1())
print(part2())
