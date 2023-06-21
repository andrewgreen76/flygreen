import copy

original_list = [1, 2, [3]]

print("")
print("Original list: " + str(original_list))
print("")
print("Adding a reference")
reference = original_list
print("")
print("Original list: " + str(original_list))
print("Reference: " + str(reference))
print("")
print("Making a shallow copy")
shallow_copy = copy.copy(original_list)
print("")
print("Original list: " + str(original_list))
print("Reference: " + str(reference))
print("Shallow copy: " + str(shallow_copy))
print("")
print("Altering the shallow copy (modifying the nested list in the copy)")
shallow_copy[2].append(4)
print("")
print("Original list: " + str(original_list))
print("Reference: " + str(reference))
print("Shallow copy: " + str(shallow_copy))
print("")



#print("List at genesis: [1, 2, [3]]")
#
#print("Original list became: ")
#print(original_list)  # [1, 2, [3, 4]]
#print("Shallow copy became: ")
#print(shallow_copy)   # [1, 2, [3, 4]]
#


#print("Deep copy became: ")
#print(deep_copy)      # [1, 2, [3, 5]]

