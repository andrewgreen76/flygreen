class Num:
    def __init__(self, value):
        self.value = value

    def __add__(self, other):
        return self.value - other.value

x = Num(5)
y = Num(10)
print(x + y)
