from enum import IntEnum


DIRECTIONS = ['N', 'E', 'S', 'W']

def parse_input():
    with open('day12_input.txt', 'r') as reader:
        lines = reader.readlines()

    return [(line.strip()[0], int(line.strip()[1:])) for line in lines]

def new_heading(current_heading, direction, amount):
    heading = (current_heading + int(amount / 90 * direction)) % 4
    return heading

def rotate(waypoint, rotations):
    if rotations == 0:
        return waypoint
    else:
        return rotate((waypoint[1], -waypoint[0]), rotations - 1)

def normalised_instructions():
    heading = 1 # East
    normalised_instructions = []
    instructions = parse_input()

    for instruction, amount in instructions:
        if instruction == 'L':
            heading = new_heading(heading, -1, amount)
        elif instruction == 'R':
            heading = new_heading(heading, 1, amount)
        elif instruction == 'F':
            normalised_instructions.append((DIRECTIONS[heading], amount))
        else:
            normalised_instructions.append((instruction, amount))

    return normalised_instructions

def part1():
    east_west = 0
    north_south = 0

    instructions = normalised_instructions()

    for instruction, amount in instructions:
        if instruction == 'E':
            east_west += amount
        elif instruction == 'W':
            east_west -= amount
        elif instruction == 'N':
            north_south += amount
        elif instruction == 'S':
            north_south -= amount

    return abs(north_south) + abs(east_west)

def part2():
    waypoint = (10, 1)
    heading = 1 # east
    east_west = 0
    north_south = 0

    instructions = parse_input()

    for instruction, amount in instructions:
        if instruction == 'E':
            waypoint = (waypoint[0] + amount, waypoint[1])
        elif instruction == 'W':
            waypoint = (waypoint[0] - amount, waypoint[1])
        elif instruction == 'N':
            waypoint = (waypoint[0], waypoint[1] + amount)
        elif instruction == 'S':
            waypoint = (waypoint[0], waypoint[1] - amount)
        elif instruction == 'L':
            old_heading = heading
            heading = new_heading(heading, -1, amount)
            rotations = (heading - old_heading) % 4
            waypoint = rotate(waypoint, rotations)
        elif instruction == 'R':
            old_heading = heading
            heading = new_heading(heading, 1, amount)
            rotations = (heading - old_heading) % 4
            waypoint = rotate(waypoint, rotations)
        elif instruction == 'F':
            north_south += amount * waypoint[1]
            east_west += amount * waypoint[0]

    return abs(north_south) + abs(east_west)

print(part1())
print(part2())
