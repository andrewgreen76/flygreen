def func_stack():
    stack = ["car", "candy", "fruit", "bike"]
    results = (stack.pop(1) if stack.pop(0) != "candy" else stack.pop())

    return results

print(func_stack())
