import sys

def part1(path):
    file = open(path, "r")
    counter=0
    for line in file:
     counter+=1
     line=line.strip('\n')
     arr = line.split(' ')
     if (containsDuplicates(arr)) :
         counter-=1

    return counter


def part2(path):
    file = open(path, "r")
    counter=0
    for line in file:
     counter+=1
     line=line.strip('\n')
     arr = line.split(' ')
     if (containsDuplicates(arr) or containsAnagrams(set(arr))) :
         counter-=1

    return counter


def containsDuplicates(arr):
    if len(arr) != len(set(arr)):
        return True
    else: return False


def containsAnagrams(setLine):

    for values1 in setLine:
        for values2 in setLine:
            if (sorted(values1) == sorted(values2)) and (values1 != values2):
                return True
    return False




print("Part 1:",part1(sys.argv[1]))
print("Part 2:",part2(sys.argv[1]))
