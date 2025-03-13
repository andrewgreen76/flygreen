def my_func():
    data = [2, 4, 6, 8, 10, 12]
    result = [num for num in data if num % 3 == 0]
    # print(result[-2])
    return result[::-1][-2] + result[-2]

print(my_func())

# divisibility ... and ...
# result = [6, 12]
# [::-1] - reversal of the list = [12, 6]
# NEGATAIVE INDEXING
