ol = [4, [5]]  # A reference called 'w' is created to point to the list object.  
ref = w    # Creating another reference to the same object. 
shc = w.copy()    # Creating a shallow copy of the list. 
dpc = w.deepcopy()    # Creating a deep copy of the list. 

w.append(6)



print(x) # is another REFERENCE to the list of [2]. 

print(y) # [2, 6]
# This is called a    SHALLOW COPY    , which is a copy of the reference to the original object.
# - created using simple name binding (an alias/pointer/name for the same object).

print(z) # [2]       # This is called a    DEEP COPY       , which is a copy of the object itself.  
