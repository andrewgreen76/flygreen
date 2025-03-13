lamb_func = lambda x,y: y * (lambda y: y * 2)(x + 5)

result = lamb_func(3, 2)
print(result)
