# nums = [3,3], target = 6

import sys
import re

instring = ' '.join(sys.argv[1:])    # CUT OFF THE FILENAME -> RENDER SYS.ARGV.TEXTTOKENS AS ONE STRING
nums = re.findall(r'\d+', instring)   # Now detect all NUMBERS-AS-STRINGS

# List comprehension: 
nums = [int(e) for e in nums]
    
target = nums[ len(nums)-1 ]   # TARGET
nums = nums[:-1]                 # NUMS

for a in nums[:-1]:
    for b in nums[ nums.index(a)+1 : ]:
        if (a+b)==target:
            result = []
            result.append( nums.index(a) )
            result.append( nums.index(b) )
            
            print(result)
            #return result
