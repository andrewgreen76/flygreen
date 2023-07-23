
# all() checks for any element within the given list that is falsey. But since the list is empty, it does not have a falsey item, so all() will return True.

print("all([]):", all([]))
print("all([[]]):", all([[]]))
print("all([[[]]]):", all([[[]]]))
print("all([[[[]]]]):", all([[[[]]]]))
print("all([[[[[]]]]]):", all([[[[[]]]]]))

