def modify_list_fruits(fruits):
    fruit_set = set(fruits)
    fruit_set.add("pear")
    fruit_set.remove("apple")
    fruit_list = list(fruit_set)
    return fruit_list[1]

fruits = ["apple", "banana", "orange"]

print(modify_list_fruits(fruits))
