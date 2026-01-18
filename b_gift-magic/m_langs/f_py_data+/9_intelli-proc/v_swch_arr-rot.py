#    arr[:d], arr[d:] = arr[-d:], arr[:-d]

arr = [-3, -2, -1, 0, 1, 2, 3]
d=2

print(arr[:d]) # [-3, -2]
print(arr[d:]) # [-1, 0, 1, 2, 3]
print(arr[-d:]) # [2, 3]
print(arr[:-d]) # [-3, -2, -1, 0, 1]

arr[:d], arr[d:] = arr[-d:], arr[:-d]

print(arr)
