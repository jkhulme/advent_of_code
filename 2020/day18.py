def parse_input():
    return [
        '2 * 3 + (4 * 5)',
        '5 + (8 * 3 + 9 + 3 * 4 * 3)',
        '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'
    ]

def evaluate(expression):
    for i, e in enumerate(expression):
        if e.startswith('('):
            start = i
        if e.endswith(')'):
            end = i
            expression[start] = expression[start].replace('(', '')
            expression[end] = expression[end].replace(')', '')
            expression[start:end + 1] = [sub_evaluate(expression[start:end + 1])]

    print(expression)

    return sub_evaluate(expression)

def sub_evaluate(expression):
    if len(expression) == 1:
        return int(expression[0])

    sub_expression = expression[0:3]
    a = sub_expression[0]
    b = sub_expression[2]
    op = sub_expression[1]
    if op == '+':
        total = int(a) + int(b)
    elif op == '*':
        total = int(a) * int(b)

    expression[0:3] = [total]

    return sub_evaluate(expression)


def part1():
    expressions = parse_input()
    return [evaluate(expression.split(' ')) for expression in expressions]

print(part1())
