def my_func(a=[]):
    a.append(1)
    return a

print(f"{my_func()} {my_func()}")
