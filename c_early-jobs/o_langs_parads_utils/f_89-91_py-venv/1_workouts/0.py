import re

input = "I have 2 apples and 15 oranges."

# Find all sequences of digits
numbers = re.findall(r'\d+', input)

# Print them
for num in numbers:
    print(num)
