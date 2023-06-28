cache = {}  # Initialize an empty cache

def get_data(key):
    if key in cache:  # Check if data exists in the cache
        return cache[key]
    else:
        # If data is not in the cache, retrieve it from the data source
        data = retrieve_data_from_source(key)
        cache[key] = data  # Store the data in the cache
        return data

def retrieve_data_from_source(key):
    # Perform necessary operations to retrieve data from the data source
    # For example, querying a database or making an API call
    # Here, we use a simple example of returning a string based on the key
    return f"Data for key '{key}'"

# Usage example
print(get_data("key1"))  # Retrieve data from the source and store it in the cache
print(get_data("key2"))  # Retrieve data from the source and store it in the cache
print(get_data("key1"))  # Retrieve data from the cache (no additional retrieval required)
