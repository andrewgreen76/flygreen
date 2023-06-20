x = [2]
y = x
z = x.copy()
x.append(6)

# What does 'y' hold at this point ?
# (A) [2]
# (B) [2, 6]

# What does 'z' hold at this point ?
# (A) [2]
# (B) [2, 6]

print(y) # [2, 6]
# This is called a    SHALLOW COPY    , which is a copy of the reference to the original object.
# - created using simple name binding (an alias/pointer/name for the same object).

print(z) # [2]       # This is called a    DEEP COPY       , which is a copy of the object itself. 
