def zip_function(list1, list2):
    zipped = zip(list1, list2)
    result = [(a,b) for a, b in zipped if a != b]
    return *result,

list1 = [1, 2, 3, 4, 5]
list2 = [1, 3, 3, 4, 6]
output = zip_function(list1, list2)
print(output)
