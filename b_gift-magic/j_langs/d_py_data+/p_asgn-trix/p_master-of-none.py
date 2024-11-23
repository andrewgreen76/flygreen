x, y = (0, 1) if True else None, None
print(x)

'''
Been told >1 that in Py things are assumed to be truthy unless specd otherwise somewhere in the script/REPL. 

RHS expr rets the tuple as a single elem, so the 1st var on LHS, x, will hold that tuple by default and y will get None. x = (0, 1), y = None. So, (D). 

Py out: (0, 1).
'''
