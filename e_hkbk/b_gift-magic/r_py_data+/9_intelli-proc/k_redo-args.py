def foo(a, b=2, c=3):
    print(a)
    print(b)
    print(c)
    return a + b + c

print(foo(c=1, a=3))
