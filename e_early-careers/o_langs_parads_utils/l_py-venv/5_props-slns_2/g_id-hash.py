# Define a function to check if two objects have the same identity hash
def has_same_identity(obj1, obj2):
    return hash(obj1) == hash(obj2)

# Create two string objects
obj1 = "Hello"
obj2 = "Hello"

# Check if obj1 and obj2 have the same identity hash
print(has_same_identity(obj1, obj2))  # True

# Assign obj2 to obj1
obj1 = obj2

# Check if obj1 and obj2 have the same identity hash after reassignment
print(has_same_identity(obj1, obj2))  # True
