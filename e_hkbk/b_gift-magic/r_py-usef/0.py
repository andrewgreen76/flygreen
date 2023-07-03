def mystery(my_list):
    n = len(my_list)
    # print(n)
    return [my_list.pop() for i in range(n)]

print(mystery([1, 3, 5, 7]))
