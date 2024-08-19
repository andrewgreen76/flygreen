
def func():
    a, *b, = ["Harry","Precious", "Peter"]
    names = b
    return "peter" in names
    
    # print("This is a:", a)
    # print("This is b:", b)
    # print(type(*b,))   - type() take 1 or 3 args ? 

print(func())

# *b,   - is of type 'list'. 
