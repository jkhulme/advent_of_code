import itertools
import math


def part1():
    departure_time = 1003055
    bus_timetable = "37,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,433,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,x,17,x,19,x,x,x,x,x,x,x,x,x,29,x,593,x,x,x,x,x,x,x,x,x,x,x,x,13"

    busses = [int(bus) for bus in bus_timetable.split(',') if bus != 'x']

    wait, bus = min([((bus * (1 + departure_time // bus)) - departure_time, bus) for bus in busses])

    return wait * bus

def calculate_t(start, step, max_t, busses, calculated_busses):
    for i in range(start, max_t, step):
        valid_busses = [bus[0] for bus in busses if (i + bus[1]) % bus[0] == 0]
        if len(valid_busses) > 1 and valid_busses != calculated_busses:
            return i, valid_busses

def part2():
    bus_timetable = "37,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,433,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,x,17,x,19,x,x,x,x,x,x,x,x,x,29,x,593,x,x,x,x,x,x,x,x,x,x,x,x,13"
    busses = [(int(bus), i) for i, bus in enumerate(bus_timetable.split(',')) if bus != 'x']

    valid_busses = []
    t = 0
    step = 1
    max_t = math.prod([bus[0] for bus in busses])

    while len(valid_busses) < len(busses):
        t, valid_busses = calculate_t(t, step, max_t, busses, valid_busses)
        step = math.prod(valid_busses)
        t, valid_busses = calculate_t(t, step, max_t, busses, valid_busses)

    return t

print(part1())
print(part2())
