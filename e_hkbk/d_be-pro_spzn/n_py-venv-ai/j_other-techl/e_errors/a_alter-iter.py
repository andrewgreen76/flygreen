x = ['a', 'b', 'c']
x = [i.upper for i in x]
x[1] = x[1]()
print(x)
