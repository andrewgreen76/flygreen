obj1 = {x: x + 1 for x in range(10)}
obj2 = (x for x in range(10))

print(type(obj1), type(obj2))
