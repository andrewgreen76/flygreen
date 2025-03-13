class Num:
    def __init__(self, x):
        self.x = x

    def __mod__(self, other):
        return self.x % other.x

x = Num(sum([7, 3, 6]))
y = Num(3)

print(x % y)
