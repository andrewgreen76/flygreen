def func():
    a, *b, c = ["Car", 'Dog', 'Tiger', 'Lion']
    item = b
    print('a:', a)
    print('b:', b)
    print('*b:', *b)
    print('c:', c)
    print('item:', item)
    print('[item]:', [item])
    return "Lion" in [item] or None

print(func())
