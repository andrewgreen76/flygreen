# If you create another reference that points to the same object the original reference points to,
# both references will reflect the same changes made to the same object. 

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
