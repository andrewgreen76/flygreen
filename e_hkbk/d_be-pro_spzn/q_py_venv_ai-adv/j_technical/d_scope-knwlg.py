def outer_func(x):
    def inner_func():
        return x
    x -= 2
    return inner_func()

print(outer_func(5))
