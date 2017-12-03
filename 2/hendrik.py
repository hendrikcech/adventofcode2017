import sys
import itertools

def checksum(input):
    sum = 0
    for line in input.splitlines():
        smallest = sys.maxsize
        largest = 0
        for v in line.split():
            value = int(v)
            if value < smallest:
                smallest = value
            if value > largest:
                largest = value
        sum += largest - smallest
    return sum

def task2(input):
    sum = 0
    for line in input.splitlines():
        values = map(int,  line.split())
        product = list(itertools.product(values,repeat=2))
        dividable = list(filter(lambda x: x[0] != x[1] and x[0] % x[1] == 0, product))
        if len(dividable) != 1:
            raise "invalid input line"
        difference = dividable[0][0] // dividable[0][1]
        sum += difference
    return sum



input = open('input.txt', 'r').read()
print("Task 1: ", checksum(input))
print("Task 2: ", task2(input))
