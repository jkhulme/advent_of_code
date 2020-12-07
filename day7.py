def normalise_bag(bag):
    bag = bag.strip()
    return bag.replace(' bags', '').replace(' bag', '')

def parse_rules():
    # This is gank, there must be a nicer way to do this
    with open('day7_input.txt', 'r') as reader:
        bag_rules = {}

        for line in reader.readlines():
            container_bag, stored_bags = line.strip().split('contain')
            container_bag = normalise_bag(container_bag)

            bag_rules[container_bag] = {}

            stored_bags = stored_bags.strip()[:-1].split(',')

            for bag in stored_bags:
                if bag == 'no other bags':
                    continue

                bag_details = bag.strip().split(' ')
                quantity = int(bag_details[0])
                bag_name = normalise_bag(' '.join(bag_details[1:]))

                bag_rules[container_bag][bag_name] = quantity

    return bag_rules

def holds_gold(bag, rules):
    if rules[bag] == {}:
        return False
    if 'shiny gold' in rules[bag].keys():
        return True

    return any([holds_gold(inner_bag, rules) for inner_bag in rules[bag]])

def count_bags(bag, rules):
    if rules[bag] == {}:
        return 1

    return 1 + sum([count_bags(inner_bag, rules) * rules[bag][inner_bag] for inner_bag in rules[bag]])

def part1():
    rules = parse_rules()
    return sum([1 for bag in rules if holds_gold(bag, rules)])

def part2():
    rules = parse_rules()
    return count_bags('shiny gold', rules) - 1

print(part1())
print(part2())
