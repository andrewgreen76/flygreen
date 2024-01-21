# Logical conjuction operation. An ALERT operator. 

def func(x):
    x *= 2

num = 10 and 5
func(num)

#x = 11
#y = 6
#a = [i and j for i in range(x) for j in range(y)]
#b = {(i, j) : i and j for i in range(x) for j in range(y)}

print(num)

'''
1) num = 10 and 5 = True (1) => x = x*2=1*2=2, no ret => x = 1 or 2.
2) num = 10 and 5 = 1010 and 0101 = 0000 = 0. 
Bust. 

Py out: 5

GPT: In Py, it's a logical oper; rets last evald operand if both operands are "truthy." Else, returns the first "falsy" operand encountered.
'''
