def my_func(value):
    if value == 5:
        return ["Python"]
    else:
        yield from range(value)

print(list(my_func(5)))
