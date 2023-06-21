import copy

original_list = [1, 2, [3]]
shallow_copy = copy.copy(original_list)

# Modify the nested list in the copies
shallow_copy[2].append(4)



print("List at genesis: [1, 2, [3]]")
#
#print("Original list became: ")
#print(original_list)  # [1, 2, [3, 4]]
#print("Shallow copy became: ")
#print(shallow_copy)   # [1, 2, [3, 4]]
#


#print("Deep copy became: ")
#print(deep_copy)      # [1, 2, [3, 5]]
