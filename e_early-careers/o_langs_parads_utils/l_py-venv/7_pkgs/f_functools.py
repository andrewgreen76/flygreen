from functools import reduce

values = [8, 10, 6, 3, 4, 0]
print(reduce(lambda x, y: [y, *x], values, []))
