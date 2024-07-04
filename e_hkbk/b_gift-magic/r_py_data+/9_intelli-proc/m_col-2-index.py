def func(words, nums):
    result = tuple(w[:][2] for w in words or nums)
    return result

tuple_of_words = ("apple", "banana", "cherry")
list_of_nums = [1,2,3]

print(func(tuple_of_words, list_of_nums))
