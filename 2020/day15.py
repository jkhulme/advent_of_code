last_spoken_when = {}
numbers = []

def first_time(last_spoken):
    return len(last_spoken_when[last_spoken]) <= 1

def say(i, number):
    if number in last_spoken_when:
        last_spoken_when[number].append(i)
    else:
        last_spoken_when[number] = [i]

    numbers.append(number)

def part1(seed, goal):
    for i, number in enumerate(seed):
        say(i, number)

    for i in range(len(seed), goal):
        last_spoken = numbers[i - 1]
        if first_time(last_spoken):
            say(i, 0)
        else:
            last_spoken_at = last_spoken_when[last_spoken][-2:]
            say(i, last_spoken_at[1] - last_spoken_at[0])

    return numbers[-1]

print(part1([0,13,16,17,1,10,6], 2020))
last_spoken_when = {}
numbers = []
print(part1([0,13,16,17,1,10,6], 30000000))
