def destination_idx(cups, destination_label):
    min_label = min(cups)

    if destination_label < min_label:
        return cups.index(max(cups))
    elif destination_label in cups:
        return cups.index(destination_label)
    else:
        return destination_idx(cups, destination_label - 1)

def play(cups, current_cup_idx):
    current_cup = cups[current_cup_idx]
    pick_up = [
        cups[(current_cup_idx + 1) % len(cups)],
        cups[(current_cup_idx + 2) % len(cups)],
        cups[(current_cup_idx + 3) % len(cups)]
    ]
    for cup in pick_up:
        del cups[cups.index(cup)]
    destination_cup_idx = destination_idx(cups, current_cup - 1)
    cups[destination_cup_idx + 1: destination_cup_idx + 1] = pick_up
    current_cup_idx = (cups.index(current_cup) + 1) % len(cups)
    return cups, current_cup_idx

def post1(cups):
    idx1 = cups.index(1)
    l = len(cups)
    result = []
    for i in range(1, l):
        idx = (i + idx1) % l
        result.append(str(cups[idx]))

    return result

def part1():
    cups = [int(i) for i in '326519478']
    current_cup_idx = 0
    for i in range(0, 100):
        cups, current_cup_idx = play(cups, current_cup_idx)

    return ''.join(post1(cups))

print(part1())
