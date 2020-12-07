def find_partition(bsp, limit, upper_id, lower_id):
    min_partition = 0
    max_partition = limit

    for partition in bsp[:-1]:
        if partition == lower_id:
            max_partition = min_partition + (max_partition - min_partition) / 2
        if partition == upper_id:
            min_partition = min_partition + 1 + (max_partition - min_partition) / 2

    if bsp[-1] == lower_id:
        return min_partition
    if bsp[-1] == upper_id:
        return max_partition

def seat_id(row, column):
    return (row * 8) + column

def known_seat_ids():
    with open('day5_input.txt', 'r') as reader:
        seat_ids = []
        for line in reader.readlines():
            row = find_partition(line.strip()[:7], 127, 'B', 'F')
            column = find_partition(line.strip()[-3:], 7, 'R', 'L')
            seat_ids.append(seat_id(row, column))

    return seat_ids

def all_seat_ids():
    seat_ids = []
    for row in range(0, 128):
        for column in range(0, 8):
            seat_ids.append(seat_id(row, column))

    return seat_ids

def part1():
    return max(known_seat_ids())

def part2():
    known = known_seat_ids()
    all_possible = all_seat_ids()
    unknown = set(all_possible) - set(known)
    my_seats = []
    for seat in unknown:
        if seat + 1 in known or seat - 1 in known:
            my_seats.append(seat)

    # With this input returns 3, one towards back, one towards front.  So
    # based on description of task I'm taking the middle one
    return my_seats[1]


print(part1())
print(part2())
