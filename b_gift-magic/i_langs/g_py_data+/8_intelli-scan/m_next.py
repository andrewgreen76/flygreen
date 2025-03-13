from itertools import dropwhile

def func(array):
    filtered_list = dropwhile(lambda x:x<0, array)
    return filtered_list

numz = [-3, -2, -1, 0, 1, 2, 3]

results = func(numz)
#next(results)
print(next(results))
