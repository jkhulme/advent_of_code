def parse_input():
    return [
        # '2 * 3 + (4 * 5)',
        # '5 + (8 * 3 + 9 + 3 * 4 * 3)',
        # '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))',
        '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'
    ]

def evaluate(expression):
    print(expression)
    has_brackets = False
    for i, e in enumerate(expression):
        if e.startswith('('):
            has_brackets = True
            start = i
        if e.endswith(')'):
            end = i
            opening = expression[start].count('(')
            closing = expression[end].count(')')
            expression[start] = expression[start].replace('(', '')
            expression[end] = expression[end].replace(')', '')
            expression[start:end + 1] = ['(' * (opening - 1) + str(evaluate(expression[start:end + 1])) + ')' * (closing - 1)]

    if has_brackets:
        expression = evaluate(expression)

    return sub_evaluate(expression)

def sub_evaluate(expression):
    # Not sure why I need this case
    if isinstance(expression, int):
        return expression

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
