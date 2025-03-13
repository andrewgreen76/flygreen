# A shallow copy is not the same as a reference. A shallow copy simply reflects the changes
# made only to the nested objects (a list within a set, a list within a list, etc.).
# Shallow copies never reflect any changes made to the "superficial" or "first-order" elements
# within an object. 

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
print("Making a SHALLOW copy")
shallow_copy = copy.copy(original_list)
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Shallow copy: " + str(shallow_copy))
print("")
print("Appending 4 to the nested list of the shallow copy")
shallow_copy[2].append(4)
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Shallow copy: " + str(shallow_copy))
print("")

print("Appending 6 as a superficial/first-order element to the shallow copy")
shallow_copy.append(6)
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Shallow copy: " + str(shallow_copy))
print("")

print("Changing the first element of the original")
original_list[0] = 10
print("")
print("Original list: " + str(original_list))
print("2nd reference: " + str(reference))
print("Shallow copy: " + str(shallow_copy))
print("")
