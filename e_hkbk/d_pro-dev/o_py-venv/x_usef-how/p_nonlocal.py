# Vars to be accessed from a func as nonlocals go here. 

def multiply_func(x):
    x *= 1
    print(value)
    return value * 2

# Vars that can be accessed but don't have to be decld as nonlocals go here. 

value = 10
value = multiply_func(value)
print(value)
