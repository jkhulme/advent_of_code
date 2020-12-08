def load_piste_map():
    piste_map = []
    with open('day3_input.txt', 'r') as reader:
        for line in reader.readlines():
            piste_map.append(line.strip())

    return piste_map

def traverse_map(right, down):
    piste_map = load_piste_map()
    i = 0
    piste_width = len(piste_map[0])
    trees = 0
    for piste in piste_map[down:-1:down]:
        i = i + right
        if piste[i % piste_width] == '#':
            trees += 1

    return trees

def part1():
    return traverse_map(3, 1)

def part2():
    return (
        traverse_map(1, 1) *
        traverse_map(3, 1) *
        traverse_map(5, 1) *
        traverse_map(7, 1) *
        traverse_map(1, 2)
    )

print(part1())
print(part2())
