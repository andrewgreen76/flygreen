a = range(3)
b = range(5)

print(len(a))

x = [[i for i in a] for j in b]
print(x)

y = [(i, j) for i in a for j in b]
print(y)

z = [i for i in x*len(a)]
print(x*len(a))
