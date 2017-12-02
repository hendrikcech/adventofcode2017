numbers = []

def getOffset(input=[], task=1):
    if task == 1:
        return 1
    elif task == 2:
        return len(input) // 2


def main():
    input = open('input.txt', 'r').read().rstrip()
    for index, char in enumerate(input):
        current = int(char)
        offset = getOffset(input, task=2)
        i = (index + offset) % len(input)
        next = int(input[i])
        if current == next:
            numbers.append(current)
    print("Sum: ", sum(numbers))

main()
