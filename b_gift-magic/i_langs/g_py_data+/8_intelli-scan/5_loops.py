def func(arr1, arr2):
    return any(True if x == y else False for x in arr1 for y in arr2)

print(func([1,2,3], [4,3,2,1]))

# 
