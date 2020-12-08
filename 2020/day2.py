import csv
from collections import namedtuple

PasswordRule = namedtuple('PasswordRule', 'min, max, letter, password')
password_rules = map(PasswordRule._make, csv.reader(open("day2_input.csv", "rb")))

def valid_password_part1(password_rule):
    occurances = password_rule.password.count(password_rule.letter)
    return occurances <= int(password_rule.max) and occurances >= int(password_rule.min)

def valid_password_part2(password_rule):
    in_position_a = password_rule.password[int(password_rule.min) - 1] == password_rule.letter
    in_position_b = password_rule.password[int(password_rule.max) - 1] == password_rule.letter
    return in_position_a ^ in_position_b

def part1():
    return sum([1 for password_rule in password_rules if valid_password_part1(password_rule)])

def part2():
    return sum([1 for password_rule in password_rules if valid_password_part2(password_rule)])

print(part1())
print(part2())
