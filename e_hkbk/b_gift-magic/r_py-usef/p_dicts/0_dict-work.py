def process_data(data):
    if isinstance(data, list):
        data.pop()
        return data
    elif isinstance(data, dict):
        data.pop("Name")
        return data
    else:
        return "Unknown type"

print(process_data({"name": "Alice", "age": 30}))
