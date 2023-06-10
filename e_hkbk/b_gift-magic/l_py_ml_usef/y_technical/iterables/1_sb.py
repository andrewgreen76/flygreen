import itertools
#from itertools import tee

lst = ['1', '2', '3']

# assigns to both, no "foul play" : 
iter1, iter2 = itertools.tee(lst, 2) # not enough / too many vals to unpk. 

#print("Iter 1 - list: ", list(iter1))
print("Itertr 1 - next: ", next(iter1))
print("Itertr 1 - next: ", next(iter1))
print("Itertr 1 - list: ", list(iter1))
print("Itertr 2 - list: ", list(iter2))
