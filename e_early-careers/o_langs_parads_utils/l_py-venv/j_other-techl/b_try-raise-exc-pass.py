e = 10

try:
    raise ZeroDivisionError
except ZeroDivisionError as e:
    pass

print(e)
