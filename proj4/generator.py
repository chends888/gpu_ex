 
import math
import random


if __name__ == "__main__":
    N = int(input())
    print(N)
    sz = random.randint(1000, 10000)

    for i in range(N):
        x = random.random() * sz
        y = random.random() * sz
        print(x, y)


    # print(6)
    # print(30, 11)
    # print(2, 300)
    # print(3120, 299)
    # print(31, 2299)
    # print(321, 3299)
    # print(3212, 1299)