def new_list(item: int or str, list1 = []):
    list1.append(item)
    return list1

results = new_list(2)
new_list("boys")

print(results)
