# A deep copy is always completely independent. 

import copy

original_list = [1, 2, [3]]

print("")
print("Original list: " + str(original_list))
print("")
print("Adding another reference")
reference = original_list
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("")
print("Making a DEEP copy")
deep_copy = copy.deepcopy(original_list)
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Deep copy: " + str(deep_copy))
print("")
print("Altering the DEEP copy (modifying the nested list in the copy)")
deep_copy[2].append(5)
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Deep copy: " + str(deep_copy))
print("")

print("Changing the original list")
original_list[2].append(7)
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Deep copy: " + str(deep_copy))
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

