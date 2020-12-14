from itertools import product


def parse_input():
    instructions = []
    with open('day14_input.txt', 'r') as reader:
        lines = reader.readlines()

    for line in lines:
        instructions.append([i.strip() for i in line.split('=')])

    return instructions

def part1_mask(mask, number):
    number_bin = list("{0:b}".format(number).zfill(36))
    for i, x in enumerate(mask):
        if x != 'X':
            number_bin[i] = x

    return int(''.join(number_bin), 2)

def part1():
    mask = "X"*36
    memory = {}

    for instruction in parse_input():
        if instruction[0] == 'mask':
            mask = instruction[1]
        else:
            address = instruction[0][4:-1]
            memory[address] = part1_mask(mask, int(instruction[1]))

    return sum(memory.values())

def masked_addresses(mask, address):
    address_bin = list("{0:b}".format(address).zfill(36))
    floating = []
    addresses = []
    for i, x in enumerate(mask):
        if x == '0':
            continue
        if x == '1':
            address_bin[i] = x
        elif x == 'X':
            floating.append(i)

    if len(floating) > 0:
        permutations = product('01', repeat=len(floating))
        for permutation in permutations:
            new_address = address_bin[:]
            for i, mask_bit in enumerate(permutation):
                new_address[floating[i]] = mask_bit

            addresses.append(new_address)
    else:
        addresses.append(address_bin)

    return [int(''.join(address), 2) for address in addresses]

def part2():
    mask = "X"*36
    memory = {}

    for instruction in parse_input():
        if instruction[0] == 'mask':
            mask = instruction[1]
        else:
            address = instruction[0][4:-1]
            for masked_address in masked_addresses(mask, int(address)):
                memory[masked_address] = int(instruction[1])

    return sum(memory.values())

print(part1())
print(part2())
