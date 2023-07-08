x = [ [1], [2] ]
y = x[::-1]
print("Performing slice -1")
print('x: ', x)
print('y: ', y)
max(y).append(5)
print("Performing max(y).append(5)")
print('x: ', x)
print('y: ', y)
x[0].append(6)
print("Performing x[0].append(6)")
print('x: ', x)
print('y: ', y)

'''
Performing slice -1
x:  [[1], [2]]
y:  [[2], [1]]
Performing max(y).append(5)
x:  [[1], [2, 5]]
y:  [[2, 5], [1]]
Performing x[0].append(6)
x:  [[1, 6], [2, 5]]
y:  [[2, 5], [1, 6]]
'''
