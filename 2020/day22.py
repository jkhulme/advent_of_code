import sys
sys.setrecursionlimit(10000)

def parse_input():
    cards = {'p1': [], 'p2': []}
    p = 'p1'

    with open('day22_input.txt', 'r') as reader:
        for line in reader.readlines():
            line = line.strip()
            if line == '':
                p = 'p2'
                continue
            else:
                cards[p].append(line)

    for p in cards:
        cards[p] = [int(c) for c in cards[p][1:]]

    return cards

def play_part1(p1_cards, p2_cards):
    if len(p1_cards) == 0:
        return p2_cards
    if len(p2_cards) == 0:
        return p1_cards

    c1 = p1_cards.pop(0)
    c2 = p2_cards.pop(0)

    if c1 > c2:
        p1_cards.extend([c1, c2])
    elif c2 > c1:
        p2_cards.extend([c2, c1])

    return play_part1(p1_cards, p2_cards)

def play_part2(p1_cards, p2_cards, state):
    if p1_cards in state['p1'] and p2_cards in state['p2']:
        return 'p1', p1_cards

    state['p1'].append(p1_cards.copy())
    state['p2'].append(p2_cards.copy())

    if len(p1_cards) == 0:
        return 'p2', p2_cards
    if len(p2_cards) == 0:
        return 'p1', p1_cards

    c1 = p1_cards.pop(0)
    c2 = p2_cards.pop(0)

    if c1 <= len(p1_cards) and c2 <= len(p2_cards):
        sub_p1 = p1_cards[:c1]
        sub_p2 = p2_cards[:c2]
        p, win_hand = play_part2(sub_p1, sub_p2, {'p1': [], 'p2': []})
        if p == 'p1':
            p1_cards.extend([c1, c2])
        else:
            p2_cards.extend([c2, c1])

        return play_part2(p1_cards, p2_cards, state)

    if c1 > c2:
        p1_cards.extend([c1, c2])
    elif c2 > c1:
        p2_cards.extend([c2, c1])

    return play_part2(p1_cards, p2_cards, state)

def score(hand):
    hand.reverse()
    return sum([c * (i + 1) for i, c in enumerate(hand)])

def part1():
    cards = parse_input()
    win_hand = play_part1(cards['p1'], cards['p2'])

    return score(win_hand)

def part2():
    cards = parse_input()
    p, win_hand = play_part2(cards['p1'], cards['p2'], {'p1': [], 'p2': []})

    return score(win_hand)


print(part1())
print(part2())
