import itertools


def parse_input():
    section = 0
    rules = {}
    your_ticket = []
    nearby_tickets = []

    with open('day16_input.txt', 'r') as reader:
        lines = reader.readlines()

        for line in lines:
            # Rules
            if line == '\n':
                section += 1
                continue

            line = line.strip()

            if section == 0:
                rule = line.split(':')
                rules[rule[0].strip()] = []
                for min_max in rule[1].split('or'):
                    rules[rule[0].strip()].append([int(x.strip()) for x in min_max.split('-')])
                continue

            if section == 1:
                if line == 'your ticket:':
                    continue
                else:
                    your_ticket = [int(c) for c in line.split(',')]
                    continue

            else:
                if line == 'nearby tickets:':
                    continue
                else:
                    nearby_tickets.append([int(c) for c in line.split(',')])

    return rules, your_ticket, nearby_tickets

def valid_ticket_section(rules, ticket_section):
    return any([ticket_section >= rule[0] and ticket_section <= rule[1] for rule in rules])

def invalid_ticket_sections(rules, ticket):
    return [ticket_section for ticket_section in ticket if not valid_ticket_section(rules, ticket_section)]

def flatten(rules):
    return rules

def part1():
    rules, your_ticket, nearby_tickets = parse_input()
    rules = list(itertools.chain.from_iterable(rules.values()))
    return sum([sum(invalid_ticket_sections(rules, ticket)) for ticket in nearby_tickets])

def part2():
    rules, your_ticket, nearby_tickets = parse_input()
    # valid_tickets = [ticket for ticket in nearby_tickets if len(invalid_ticket_sections(rules, ticket)) == 0]
    # return valid_tickets

print(part1())
print(part2())
