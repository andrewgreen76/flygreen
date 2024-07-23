class MyClass:
    x = 10,
    def __init__(self):
        self.data = [3, 2, 1]
        self.data.pop(-2)

    def add_value(self, value):
        if value >= 3:
            self.data.append(value)
        else:
            self.data.pop(value)

    def sum_data(self):
        self.x = 5
        return sum(set(self.data)) + self.x

obj1 = MyClass()
obj1.x = 12
obj1.add_value(1)
obj1.add_value(3)
obj1.add_value(4)
print(obj1.sum_data())

