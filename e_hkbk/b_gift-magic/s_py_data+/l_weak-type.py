class MyClass:
    def __init__(self):
        self.my_attr = 10

obj1 = MyClass()
obj2 = MyClass()
obj2.my_attr = "15"
obj1.my_attr = obj2.my_attr + "5"
        
print(obj1.my_attr)
