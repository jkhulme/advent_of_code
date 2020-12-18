import itertools
import math


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

def find_ticket_section(tickets, rules):
    possible_sections = {}

    for i in range(0, len(tickets[0])):
        possible_sections[i] = []
        ticket_section = [ticket[i] for ticket in tickets]

        for label, rule in rules.items():
            if all([valid_ticket_section(rule, t) for t in ticket_section]):
                possible_sections[i].append(label)

    return possible_sections

def ticket_csp_solver(ticket_sections):
    known = {}
    while len(ticket_sections.keys()) != len(known.keys()):
        for i, sections in ticket_sections.items():
            if i in known:
                continue

            possible = [section for section in sections if section not in known.values()]
            if len(possible) == 1:
                known[i] = possible[0]

    return known

def part1():
    rules, your_ticket, nearby_tickets = parse_input()
    rules = list(itertools.chain.from_iterable(rules.values()))
    return sum([sum(invalid_ticket_sections(rules, ticket)) for ticket in nearby_tickets])

def part2():
    rules, your_ticket, nearby_tickets = parse_input()
    flat_rules = list(itertools.chain.from_iterable(rules.values()))
    valid_tickets = [ticket for ticket in nearby_tickets if len(invalid_ticket_sections(flat_rules, ticket)) == 0]
    ticket_sections = ticket_csp_solver(find_ticket_section(valid_tickets, rules))
    sections = [i for i, section in ticket_sections.items() if section.startswith('departure')]
    return math.prod([your_ticket[i] for i in sections])

print(part1())
print(part2())
