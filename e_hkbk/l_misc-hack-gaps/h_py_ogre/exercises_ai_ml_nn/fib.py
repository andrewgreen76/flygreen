def fib(l):
    f, s = 0, 1
    while f < l:
        print (f, end=' ') # prints 1
        f, s = s, f+s   # 0,1 -> 1, 1 -> 1, 2
    print()
fib(1000)

# use py fib.py in the command prompt 

