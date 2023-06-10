from itertools import tee

my_list = [1, 2, 3, 4, 5]

# Creating multiple iterators
iter1, iter2 = tee(my_list, 2)

