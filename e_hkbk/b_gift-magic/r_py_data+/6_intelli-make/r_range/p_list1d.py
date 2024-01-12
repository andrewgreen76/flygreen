a = range(3)
b = range(5)

x = [[i for i in a] for j in b]
print(x)

y = [(i, j) for i in a for j in b]
print(y)
