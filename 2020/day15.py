last_spoken_when = {}
last_said = -1

def first_time(last_spoken):
    return last_spoken_when[last_spoken][0] is None

def say(i, number):
    global last_said
    if number in last_spoken_when:
        last_spoken_when[number] = (last_spoken_when[number][1], i)
    else:
        last_spoken_when[number] = (None, i)

    last_said = number

def part1(seed, goal):
    for i, number in enumerate(seed):
        say(i, number)

    for i in range(len(seed), goal):
        if first_time(last_said):
            say(i, 0)
        else:
            last_spoken_at = last_spoken_when[last_said]
            say(i, last_spoken_at[1] - last_spoken_at[0])

    return last_said

print(part1([0,13,16,17,1,10,6], 2020))
last_spoken_when = {}
last_said = -1
print(part1([0,13,16,17,1,10,6], 30000000))
