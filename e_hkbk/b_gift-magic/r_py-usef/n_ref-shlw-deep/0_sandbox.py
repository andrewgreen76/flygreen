import copy

a = [1, [2]]
shallow_copy = copy.copy(a)

# Modifying the list through the shallow copy
shallow_copy[0] = 5
shallow_copy[1].append(3)

print(a)            # Output: [1, [2, 3]]
print(shallow_copy) # Output: [5, [2, 3]]
