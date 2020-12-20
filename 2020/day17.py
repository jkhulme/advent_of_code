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

def part1():
    cube = [parse_input()]
    return print_cube(expand_cube(cube))


print(part1())
