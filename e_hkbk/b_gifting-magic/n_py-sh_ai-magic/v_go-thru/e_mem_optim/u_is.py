x=[]
y=[]



# "==" returns EQUALITY IN VALUE
if x == y:
    print("x and y are the SAME")
else:
    print("x and y are the DIFFERENT")
# SAME



# "id()" returns object address. Once x=y, y=>x; two refs will point to the same object and mem will be saved.
if id(x)==id(y):
    print("x and y are the SAME")
else:
    print("x and y are the DIFFERENT")
# DIFFERENT



# "is" returns whether the two are different objects. 
if x is y:
    print("x and y are the SAME")
else:
    print("x and y are the DIFFERENT")
# DIFFERENT
x=y
if x is y:
    print("x and y are the SAME")
else:
    print("x and y are the DIFFERENT")
# SAME
    
