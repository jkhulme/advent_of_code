def parse_input():
    with open('day17_input.txt', 'r') as reader:
        return [list(line.strip()) for line in reader.readlines()]

def print_cube(cube):
    return '\n\n\n'.join(['\n'.join(print_layer(l)) for l in cube])

def print_layer(layer):
    return [''.join(l) for l in layer]

def blank_layer(layer):
    height = len(layer)
    width = len(layer[0])
    return [list('.' * (width + 2))]*(height + 2)

def expand_layer(layer):
    height = len(layer)
    width = len(layer[0])
    new_layer = []
    new_layer.append(list('.' * (width + 2)))
    for l in layer:
        new_layer.append(['.'] + l + ['.'])
    new_layer.append(list('.' * (width + 2)))
    return new_layer

def expand_cube(cube):
    new_cube = []
    new_cube.append(blank_layer(cube[0]))
    for layer in cube:
        new_cube.append(expand_layer(layer))
    new_cube.append(blank_layer(cube[0]))

    return new_cube

def neighbours(x, y, z, cube):
    max_z = len(cube)
    max_y = len(cube[0])
    max_x = len(cube[0][0])

    adjacent = [
        (x - 1, y - 1, z - 1),
        (x, y - 1, z - 1),
        (x + 1 , y - 1, z - 1),
        (x - 1, y, z - 1),
        (x, y, z - 1),
        (x + 1, y, z - 1),
        (x - 1, y + 1, z - 1),
        (x, y + 1, z - 1),
        (x + 1, y + 1, z - 1),
        (x - 1, y - 1, z),
        (x, y - 1, z),
        (x + 1 , y - 1, z),
        (x - 1, y, z),
        (x + 1, y, z),
        (x - 1, y + 1, z),
        (x, y + 1, z),
        (x + 1, y + 1, z),
        (x - 1, y - 1, z + 1),
        (x, y - 1, z + 1),
        (x + 1 , y - 1, z + 1),
        (x - 1, y, z + 1),
        (x, y, z + 1),
        (x + 1, y, z + 1),
        (x - 1, y + 1, z + 1),
        (x, y + 1, z + 1),
        (x + 1, y + 1, z + 1),
    ]

    return [(x, y, z) for x, y, z in adjacent if x >= 0 and y >= 0 and z >= 0 and x < max_x and y < max_y and z < max_z]

def new_state(x, y, z, cube):
    current_state = cube[z][y][x]
    active_neighbours = sum([1 for n in neighbours(x, y, z, cube) if cube[n[2]][n[1]][n[0]] == '#'])

    if current_state == '#' and (active_neighbours == 2 or active_neighbours == 3):
        return '#'
    elif current_state == '.' and active_neighbours == 3:
        return '#'
    else:
        return '.'

def simulate(cube):
    cube = expand_cube(cube)
    new_cube = []
    for z, layer in enumerate(cube):
        new_layer = []
        for y, row in enumerate(layer):
            new_row = []
            for x, cell in enumerate(row):
                new_row.append(new_state(x, y, z, cube))
            new_layer.append(new_row)
        new_cube.append(new_layer)

    return new_cube

def count_active(cube):
    total = 0
    for layer in cube:
        for row in layer:
            for cell in row:
                if cell == '#':
                    total += 1

    return total

def part1():
    cube = [parse_input()]
    for i in range(0, 6):
        cube = simulate(cube)
    return count_active(cube)

print(part1())
