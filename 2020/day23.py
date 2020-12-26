class Node:
    def __init__(self, data):
        pass
        self.data = int(data)
        self.next = None
        self.prev = None

    def __repr__(self):
        return str(self.data)

class LinkedList:
    def __init__(self):
        self.start_node = None
        self.lookup = {}

    def insert(self, node):
        self.lookup[node.data] = node
        if self.start_node is None:
            self.start_node = node
        else:
            n = self.start_node
            while n.next is not None:
                n = n.next
            n.next = node
            node.prev = n

    def loop(self):
        n = self.start_node
        while n.next is not None:
            n = n.next
        self.start_node.prev = n
        n.next = self.start_node

    def destination(self, pickup):
        n = self.start_node
        ignore = [n.data for n in pickup]

        d = n.data - 1
        ks = self.lookup.keys()

        while d >= min(ks):
            if d not in ignore:
                return self.lookup[d]

            d = d - 1

        return self.lookup[max(ks - ignore)]

    def __str__(self):
        output = []
        node = self.start_node
        while str(node.data) not in output:
            output.append(str(node.data))
            node = node.next

        return ''.join(output)

    def move(self, pick_up, destination):
        pre_cut = pick_up[0].prev
        post_cut = pick_up[2].next

        pre_cut.next = post_cut
        post_cut.prev = pre_cut

        pre_insert = destination
        post_insert = destination.next

        pre_insert.next = pick_up[0]
        pick_up[0].prev = pre_insert

        pick_up[2].next = post_insert
        post_insert.prev = pick_up[2]

    def find(self, label):
        return self.lookup[label]


def play(ll):
    pick_up = []
    current_cup = ll.start_node
    cup = current_cup
    for i in range(0, 3):
        cup = cup.next
        pick_up.append(cup)
    d = ll.destination(pick_up)
    ll.move(pick_up, d)

    ll.start_node = ll.start_node.next

    return ll

def post1(cups):
    idx1 = cups.index(1)
    l = len(cups)
    result = []
    for i in range(1, l):
        idx = (i + idx1) % l
        result.append(str(cups[idx]))

    return result

def link(cups):
    ll = LinkedList()
    for c in cups:
        ll.insert(Node(c))
    ll.loop()

    return ll

def part2_cups():
    cups = [int(i) for i in '326519478']
    max_cup = max(cups)
    for i in range(max_cup + 1, 1000001):
        cups.append(i)

    return cups

def part1():
    ll = link('389125467')
    for i in range(0, 100):
        ll = play(ll)

    ll.start_node = ll.find(1)

    return str(ll)[1:]

def part2():
    cups = part2_cups()
    current_cup_idx = 0
    for i in range(0, 1):
        cups, current_cup_idx = play(cups, current_cup_idx)

    return cups[1], cups[2]

print(part1())
# print(part2())
