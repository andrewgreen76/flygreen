def func():
    func_locals = locals() # func_locals is a copy of, not a ref to, locals()
    x = 2
    y = 3
    print(func_locals)

func()
