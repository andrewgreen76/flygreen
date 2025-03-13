import itertools

lst = ['1', '2', '3']

iter1, iter2 = itertools.tee(lst, 2)

print("Iter 1 : ", next(iter1))
print("Iter 1 : ", list(iter1))
print("Iter 2 : ", list(iter2))
