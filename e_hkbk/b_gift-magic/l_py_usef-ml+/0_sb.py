x = [1, 4, 2]
x = [list(range(i)) for i in x]
print(x)
x = [i.append for i in x]
print(x)
x[1] = x[1](4)
print(x)
