w='a'*4096
x='a'*4096

c = w is x

y='a'*4097
z='a'*4097

d = y is z

print(c,d)
