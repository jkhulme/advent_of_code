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
        self.last_node = None
        self.lookup = {}
        self.max_label = 0

    def insert(self, node):
        self.lookup[node.data] = node
        if node.data > self.max_label:
            self.max_label = node.data

        if self.start_node is None:
            self.start_node = node
            self.last_node = node
        else:
            self.last_node.next = node
            node.prev = self.last_node
            self.last_node = node

    def loop(self):
        self.start_node.prev = self.last_node
        self.last_node.next = self.start_node

    def destination(self):
        n = self.start_node
        ignore = [n.next.data, n.next.next.data, n.next.next.next.data]

        d = n.data - 1

        while d > 0:
            if d not in ignore:
                return self.lookup[d]

            d = d - 1

        max_key = self.max_label
        while True:
            if max_key not in ignore:
                return self.lookup[max_key]
            max_key = max_key - 1

    def __str__(self):
        output = []
        node = self.start_node
        while str(node.data) not in output:
            output.append(str(node.data))
            node = node.next

        return ''.join(output)

    def move(self, destination):
        cut_start = self.start_node.next
        cut_end = cut_start.next.next

        cut_start.prev.next = cut_end.next
        cut_end.next.prev = cut_start.prev

        cut_end.next = destination.next
        destination.next.prev = cut_end

        destination.next = cut_start
        cut_start.prev = destination

    def find(self, label):
        return self.lookup[label]


def play(ll):
    pick_up = []
    current_cup = ll.start_node
    cup = current_cup
    d = ll.destination()
    ll.move(d)

    ll.start_node = ll.start_node.next

    return ll

def link(cups):
    ll = LinkedList()
    for c in cups:
        ll.insert(Node(c))

    return ll

def pad(ll, min_c, max_c):
    for i in range(min_c + 1, max_c + 1):
        ll.insert(Node(i))

    return ll

def part1():
    ll = link('326519478')
    ll.loop()

    for i in range(0, 100):
        ll = play(ll)

    ll.start_node = ll.find(1)

    return str(ll)[1:]

def part2():
    cups = '326519478'
    ll = link(cups)
    ll = pad(ll, len(cups), 1000000)
    ll.loop()

    print("playing")
    for i in range(0, 10000000):
        ll = play(ll)

    n1 = ll.find(1)
    n1_n = n1.next
    n1_nn = n1_n.next

    return n1_n.data * n1_nn.data

print(part1())
print(part2())
