x=30

def outer_function():

    x = 10 + 4

    def inner_function():
        nonlocal x
        x = 20

    x = 12 + x

    return x

print(outer_function())
