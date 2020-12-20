def parse_input():
    with open('day17_input.txt', 'r') as reader:
        return [list(line.strip()) for line in reader.readlines()]

def print_cube(cube):
    for i, layer in enumerate(cube):
        print('z' + str(i))
        print('\n'.join(print_layer(layer)))
        print('\n')

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

    adjacent = []

    for new_z in range(z - 1, z + 2):
        for new_y in range(y - 1, y + 2):
            for new_x in range(x - 1, x + 2):
                if new_x == x and new_y == y and new_z == z:
                    continue
                else:
                    adjacent.append((new_x, new_y, new_z))

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

def print_hyper(cubes):
    for i, cube in enumerate(cubes):
        print('w' + str(i))
        print(print_cube(cube))
        print('\n\n\n')

def blank_cube(cube):
    depth = len(cube)
    height = len(cube[0])
    width = len(cube[0][0])
    return [[list('.' * (width + 2))]*(height + 2)]* (depth + 2)

def expand_hyper(cubes):
    new_hyper = []
    new_hyper.append(blank_cube(cubes[0]))
    for cube in cubes:
        new_hyper.append(expand_cube(cube))
    new_hyper.append(blank_cube(cubes[0]))

    return new_hyper

def neighbours2(x, y, z, w, hyper):
    max_w = len(hyper)
    max_z = len(hyper[0])
    max_y = len(hyper[0][0])
    max_x = len(hyper[0][0][0])

    adjacent = []

    for new_w in range(w - 1, w + 2):
        for new_z in range(z - 1, z + 2):
            for new_y in range(y - 1, y + 2):
                for new_x in range(x - 1, x + 2):
                    if new_x == x and new_y == y and new_z == z and new_w == w:
                        continue
                    else:
                        adjacent.append((new_x, new_y, new_z, new_w))

    return [(x, y, z, w) for x, y, z, w in adjacent if x >= 0 and y >= 0 and z >= 0 and w >= 0 and x < max_x and y < max_y and z < max_z and w < max_w]

def new_state2(x, y, z, w, hyper):
    current_state = hyper[w][z][y][x]
    active_neighbours = sum([1 for n in neighbours2(x, y, z, w, hyper) if hyper[n[3]][n[2]][n[1]][n[0]] == '#'])

    if current_state == '#' and (active_neighbours == 2 or active_neighbours == 3):
        return '#'
    elif current_state == '.' and active_neighbours == 3:
        return '#'
    else:
        return '.'

def simulate2(hyper):
    hyper = expand_hyper(hyper)
    new_hyper = []
    for w, cube in enumerate(hyper):
        new_cube = []
        for z, layer in enumerate(cube):
            new_layer = []
            for y, row in enumerate(layer):
                new_row = []
                for x, cell in enumerate(row):
                    new_row.append(new_state2(x, y, z, w, hyper))
                new_layer.append(new_row)
            new_cube.append(new_layer)
        new_hyper.append(new_cube)

    return new_hyper

def count_active2(cubes):
    total = 0
    for cube in cubes:
        for layer in cube:
            for row in layer:
                for cell in row:
                    if cell == '#':
                        total += 1

    return total

def part2():
    cubes = [[parse_input()]]
    for i in range(0, 6):
        cubes = simulate2(cubes)

    return count_active2(cubes)

print(part2())
