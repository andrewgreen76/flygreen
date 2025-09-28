# nums = [2,7,11,15], target = 9

import sys

nums = sys.argv[3]
nums = nums[:-1]      # THE TRIM
target = sys.argv[6]

for i in nums:
    print(i)
    decapnums = nums[-1:]
    for j in decapnums:
        if (i+j)==target:
            print("[" + nums.index(i) + "," + nums.index(i) + "]")

print( nums )
print( target )
