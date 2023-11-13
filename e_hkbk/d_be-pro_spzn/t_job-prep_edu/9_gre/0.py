
mid_lim = 5
max_sl = mid_lim*2-1  

for i in range(1, max_sl+1) :  
    print('*' * abs(mid_lim - abs(mid_lim-i)) )

# . . . .    
# # . . .    
# # # . .    
# # # # .
# # # # #    

# . . . .    i=0 ; lns=1
# # . . .    i=1 ; lns=2
# # # . .    i=2 ; lns=3
# # . . .    i=3 ; lns=4
# . . . .    i=4 ; lns=5

