def mystery(my_list):
    n = len(my_list)
    return [my_list.pop() for i in range(n)]

a = [1, 3, 5, 7]
print(mystery(a))
#a.pop()
print(a)
