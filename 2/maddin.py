def getArrayFromFile(fileName):
    result = []
    for line in open(fileName, 'r').read().splitlines():
        lineArray = []
        for v in line.split():
            lineArray.append(int(v))
        result.append(lineArray)
    return result

def task1(inArray):
    summe = 0
    for array in inArray:
        summe += abs(max(array) - min(array))
    return summe

def task2(inArray):
    summe = 0
    for array in inArray:
        array.sort(reverse=True)
        length = len(array)
        for i in range(0,length):
            for other in array[i+1:length]:
                if array[i] % other == 0:
                    summe += int(array[i] / other)
    return summe

if __name__ == "__main__":
    ar = getArrayFromFile('maddinsInput.txt')
    print(task1(ar))
    print(task2(ar))
