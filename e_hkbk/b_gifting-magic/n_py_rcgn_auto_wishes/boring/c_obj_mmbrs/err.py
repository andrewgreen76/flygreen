class A:
    def __int__(self, param):
        self.a = param

class B(A):
    def __init__(self, param):
        self.b = param

obj = B(50)
print(obj.a, obj.b)
