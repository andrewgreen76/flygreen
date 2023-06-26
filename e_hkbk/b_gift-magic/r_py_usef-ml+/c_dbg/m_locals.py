def func():
    x = 2
    func_locals = locals() # func_locals is a copy of, not a ref to, locals()
    y = 3
    print(func_locals)

func()
