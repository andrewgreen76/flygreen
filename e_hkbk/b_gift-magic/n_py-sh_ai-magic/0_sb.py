def mystery(arr, d):
    d %= len(arr)
    arr[:d], arr[d:] = arr[-d:], arr[:-d]

print
