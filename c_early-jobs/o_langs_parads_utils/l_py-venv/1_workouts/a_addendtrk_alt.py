# nums = [3,3], target = 6

import sys
import re

instring = ' '.join(sys.argv[1:])    # CUT OFF THE FILENAME -> RENDER SYS.ARGV.TEXTTOKENS AS ONE STRING
nums = re.findall(r'\d+', instring)   # Now detect all NUMBERS-AS-STRINGS

# List comprehension: 
nums = [int(e) for e in nums]
    
target = nums[ len(nums)-1 ]   # TARGET
nums = nums[:-1]                 # NUMS

for a in range( len(nums) - 1 ):
    for b in range( a+1 , len(nums) ):
        if nums[a] + nums[b] == target:
            result = []
            result.append( a )
            result.append( b )
            
            print(result)
            #return result
