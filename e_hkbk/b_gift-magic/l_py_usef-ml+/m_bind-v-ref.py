x = [2]
y = x
z = x.copy()
x.append(6)

# What does y hold at this point ?
# (A) [2]
# (B) [2, 6]

print(y) # [2, 6]    # This is called a    SHALLOW COPY
print(z) # [2]       # This is called a    DEEP COPY 
