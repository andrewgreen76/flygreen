class MyClass:
    def __init__(self, value):
        self.value = value
    def __repr__(self):
        return f"{self.__class__.__name__}({self.value!r})"

left = MyClass("100")
right = MyClass("200")
uniques = {left, right}
print(uniques)
