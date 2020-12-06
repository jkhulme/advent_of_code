import re


def parse_credentials():
    with open('day4_input.txt', 'r') as reader:
        lines = reader.readlines()
        credential_string = ""
        credentials = []
        for line in lines:
            if line == '\n':
                credentials.append(parse_credential(credential_string))
                credential_string = ""
                continue
            credential_string += line
        else:
            credentials.append(parse_credential(credential_string))

    return credentials

def parse_credential(credential_string):
    credential = {}
    for c in credential_string.strip().replace('\n', ' ').split(' '):
        k,v = c.split(':')
        if k != 'cid':
            credential[k] = v

    return credential

REQUIRED_FIELDS = ['ecl', 'pid', 'eyr', 'hcl', 'byr', 'iyr', 'hgt']
def valid_credential_part1(credential):
    for field in REQUIRED_FIELDS:
        if field not in credential:
            return False

    return True

def valid_byr(byr):
    if byr is None:
        return False
    if len(byr) != 4:
        return False

    return int(byr) >= 1920 and int(byr) <= 2002

def valid_iyr(iyr):
    if iyr is None:
        return False
    if len(iyr) != 4:
        return False

    return int(iyr) >= 2010 and int(iyr) <= 2020

def valid_eyr(eyr):
    if eyr is None:
        return False
    if len(eyr) != 4:
        return False

    return int(eyr) >= 2020 and int(eyr) <= 2030


def valid_hgt(hgt):
    # TODO: Regex would be neater

    if hgt is None:
        return False

    unit = hgt[-2:]
    height = hgt[:-2]
    if height == '':
        return False

    height = int(height)

    if unit == 'cm':
        return height >= 150 and height <= 193

    if unit == 'in':
        return height >= 59 and height <= 76

    return False

def valid_hcl(hcl):
    if hcl is None:
        return False

    return bool(re.search('^#[a-f0-9]{6}$', hcl))

def valid_ecl(ecl):
    return ecl in ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

def valid_pid(pid):
    if pid is None:
        return False

    return bool(re.search('^[0-9]{9}$', pid))

def valid_credential_part2(credential):
    return (
        valid_byr(credential.get('byr')) and
        valid_iyr(credential.get('iyr')) and
        valid_eyr(credential.get('eyr')) and
        valid_hgt(credential.get('hgt')) and
        valid_hcl(credential.get('hcl')) and
        valid_ecl(credential.get('ecl')) and
        valid_pid(credential.get('pid'))
    )

def part1():
    return sum([1 for credential in parse_credentials() if valid_credential_part1(credential)])

def part2():
    return sum([1 for credential in parse_credentials() if valid_credential_part2(credential)])

print(part1())
print(part2())
