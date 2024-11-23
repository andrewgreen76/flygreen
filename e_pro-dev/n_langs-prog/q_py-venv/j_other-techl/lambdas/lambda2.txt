x = lambda x: (x, print('i'))
y = lambda x: x

z = lambda f: (f(0), f(1))

result = f'{(y(1) in x(1))}, {(z(x) in z(y))}'

print(result)
