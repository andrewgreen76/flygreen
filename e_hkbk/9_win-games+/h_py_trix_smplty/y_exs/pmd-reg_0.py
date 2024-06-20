
def print_pmd(mid_lim):
    max_sl = mid_lim*2  #   5*2-1 = 9 ; let max_sl=10 to remove -1+1
    for i in range(1, max_sl) :  #    let i={1,..,10}, does not reach 10
        print('*' * abs(mid_lim - abs(mid_lim-i)) )

print_pmd(5)
        
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

