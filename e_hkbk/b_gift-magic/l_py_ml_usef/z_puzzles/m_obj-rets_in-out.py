def outer_func(x):
    y = 1 + x              # 2) x = 4 announced here ; y = 5
    def inner_func():
        x = 2               # z) considered, and then rejected 
        def inner_inner():
            x = 3           # 3) x = 3
            return x + y    # 4) 3 + 5 = 8
        return inner_inner  # 5) ret 8 
    return inner_func       # 6) ret 8

results = outer_func(4)    # 1) x = 4 ; 7) rets 8 ; 8) results = 8
my_results = results()
print(my_results() + 2)    # 9) print(8 + 2) 
