def div(a,b):
    try:
        result=a/b
        return result
    except ZeroDivisionError:
        return 'I\'m not dividing by zero. Fuck you!'

result = div(10,0)
print(result)
