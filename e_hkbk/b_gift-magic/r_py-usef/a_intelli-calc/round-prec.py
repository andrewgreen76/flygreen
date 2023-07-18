def my_func(x, y, **kwargs):
    result = sum((x + y, x * y, x - y, x / y)) # 5 + 6 + -1 + 0.67 = 10.67 = result 
    if "round" in kwargs:
        return round(result, kwargs["round"]) # round to two digits after decimal pt 

result = my_func(2, 3, round=2)
print(result)
