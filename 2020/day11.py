def parse_input():
    with open('day11_input.txt', 'r') as reader:
        lines = reader.readlines()

    return [line.strip() for line in lines]

def adjacent_seats(x, y, seats):
    num_rows = len(seats)
    num_seats = len(seats[0])

    adjacent = [
        (x - 1, y - 1),
        (x, y - 1),
        (x + 1, y - 1),
        (x - 1, y),
        (x + 1, y),
        (x - 1, y + 1),
        (x, y + 1),
        (x + 1, y + 1)
    ]
    return [(x, y) for x, y in adjacent if x >= 0 and y >= 0 and x < num_rows and y < num_seats]

def next_diag_visible_seat(x, x_step, y, y_step, seats):
    if x < 0 or x >= len(seats):
        return None
    if y < 0 or y >= len(seats[0]):
        return None
    if seats[x][y] != '.':
        return (x, y)

    return next_diag_visible_seat(x + x_step, x_step, y + y_step, y_step, seats)

def visible_seats(x, y, seats):
    adjacent = []
    num_rows = len(seats)
    num_seats = len(seats[0])

    # North
    for i in range(x - 1, -1, -1):
        if seats[i][y] != '.':
            adjacent.append((i, y))
            break

    # South
    for i in range(x + 1, num_rows):
        if seats[i][y] != '.':
            adjacent.append((i, y))
            break

    # East
    for i in range(y + 1, num_seats):
        if seats[x][i] != '.':
            adjacent.append((x, i))
            break

    # West
    for i in range(y - 1, -1, -1):
        if seats[x][i] != '.':
            adjacent.append((x, i))
            break

    # North East
    adjacent.append(next_diag_visible_seat(x - 1, -1, y + 1, 1, seats))

    # North West
    adjacent.append(next_diag_visible_seat(x - 1, -1, y - 1, -1, seats))

    # South East
    adjacent.append(next_diag_visible_seat(x + 1, 1, y + 1, 1, seats))

    # South West
    adjacent.append(next_diag_visible_seat(x + 1, 1, y - 1, -1, seats))

    return [seat for seat in adjacent if seat is not None]

def count_adjacent_occupied(x, y, seats, seats_to_check_func):
    to_check = seats_to_check_func(x, y, seats)

    total = 0
    for a,b in to_check:
        if seats[a][b] == '#':
            total += 1

    return total

def next_state(seats, seats_to_check_func, occupied_threshold):
    state = []
    for i, row in enumerate(seats):
        new_row = []
        for j, seat in enumerate(row):
            adjacent_occupied = count_adjacent_occupied(i, j, seats, seats_to_check_func)
            if seat == 'L' and adjacent_occupied == 0:
                new_row.append('#')
            elif seat == '#' and adjacent_occupied >= occupied_threshold:
                new_row.append('L')
            else:
                new_row.append(seat)

        state.append(''.join(new_row))

    return state

def count_occupied(seats):
    occupied = 0
    for row in seats:
        for seat in row:
            if seat == '#':
                occupied += 1

    return occupied

def find_steady_state_occupied_seat_count(seats_to_check_func, occupied_threshold):
    seats = parse_input()
    while True:
        old_seats = seats
        seats = next_state(seats, seats_to_check_func, occupied_threshold)
        if old_seats == seats:
            return count_occupied(seats)

    return -1

def part1():
    return find_steady_state_occupied_seat_count(adjacent_seats, 4)

def part2():
    return find_steady_state_occupied_seat_count(visible_seats, 5)

print(part1())
print(part2())
