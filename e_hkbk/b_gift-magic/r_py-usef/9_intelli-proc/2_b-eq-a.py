#!/usr/bin/env python3

a = [1, 2, 3]    # a -> the master list [1, 2, 3]
print("Committing \"b = a\"")
b = a    # b -> the same master list [1, 2, 3]
print("b -> ", b)
print("Committing \"a = [4, 5, 6]\"")
a = [4, 5, 6]   # b still -> the same [1, 2, 3] ; a -> [4, 5, 6] . Re-ref, not mutation. 
print("b -> ", b)

# If a -> [1, 2, 3] and then a -> [4, 5, 6] , GC would take care of [1, 2, 3].

