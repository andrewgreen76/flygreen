# nums = [2,7,11,15], target = 9

import sys
import re

instring = ' '.join(sys.argv[1:])    # CUT OFF THE FILENAME -> RENDER SYS.ARGV.TEXTTOKENS AS ONE STRING
nums = re.findall(r'\d+', instring)   # NOW DETECT ALL NUMBERS

target = nums[ len(nums)-1 ]
nums = nums[:-1]

print( nums )
print( target )
