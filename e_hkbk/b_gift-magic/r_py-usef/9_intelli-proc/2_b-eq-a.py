#!/usr/bin/env python3

a = [1, 2, 3]    # a -> its own [1, 2, 3]
print("Committing \"b = a\"")
b = a    # b -> copy of [1, 2, 3]
print("b -> ", b)
print("Committing \"a = [4, 5, 6]\"")
a[0] = 5
print("b -> ", b)
