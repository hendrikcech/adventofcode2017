import math

if __name__ == "__main__":
    inputValue = 289326
    currentX = int((math.sqrt(inputValue)+1)/2)
    stepsLeft = (4 * currentX * currentX) - inputValue
    stepsLeft = stepsLeft % (currentX * 2)
    print(currentX + abs(currentX - stepsLeft))
