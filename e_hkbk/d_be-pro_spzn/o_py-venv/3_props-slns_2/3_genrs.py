nums = range(4)

x = (i/2 for i in nums)
print(x)

z = {i:'Odd' if i%2 else 'Even' for i in nums}
print(z)
