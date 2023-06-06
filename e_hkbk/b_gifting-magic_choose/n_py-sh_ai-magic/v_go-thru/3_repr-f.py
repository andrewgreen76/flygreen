
message = "Hello, world!"

print(f"Message: {message!s}", end='\n'*2)
print(f"Representation: {message!r}")

# You guess right ser, but your explanation isn’t really True.
# The `repr()` returns an official representation that can be copy-pasted into code. By adding quotes to the outputted string. 


#  Representation Formatting:
#  By using `{variable!s}` or `{variable!r}`, you can control the string representation of variables. `!s` provides a readable string representation, while `!r` offers an official representation that can be copy-pasted into code.

