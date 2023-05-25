c = [5, 6]
a = [1, 2, 3]
b = a = c
b[0] = 0

print("Same" if id(a)==id(b) and b is c else "Different")
