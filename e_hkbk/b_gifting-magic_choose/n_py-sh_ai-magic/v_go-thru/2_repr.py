def equal_len(x, y, /):
    if len(x) == len(y):
        return True
    else:
        return False

message = "Hello, World!"

str_message = str(message)
repr_message = repr(message)

print(equal_len(str_message, repr_message))
