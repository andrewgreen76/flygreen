def process_data(data):
    unique_values = set()
    all_values = ()

    for item in data:
        unique_values.add(item)
        all_values += (item,)

    return unique_values in all_values

data = [1, 2, 3, 2, 4, 5, 3 ,6]

print(process_data(data))
