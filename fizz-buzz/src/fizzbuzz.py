""" fizz buzz """

import sys

print("fizz buzz")
print("=========")
values: int = sys.argv[1] if len(sys.argv) > 1 else 20

for i in range(1, int(values) + 1):
    if (i % 3 == 0) and (i % 5 == 0):
        print("fizzbuzz")
    elif i % 3 == 0:
        print("fizz")
    elif i % 5 == 0:
        print("buzz")
    else:
        print(i)
