print("========== How it's NOT done: ==========")

a = [2, 3]
print(a)

for i in a:
    print(i)
    i = i + 2
    print(i)
    print("")
    
print(a)
print("")
print("========== Also how it's NOT done: ==========")
print("")

a = [2, 3]
print(a)

for i in a:
    #print(a[i])
    #i = i + 2

print("")
print("========== Also how it's NOT done: ==========")
print("")
a = [2, 3]

for i in len(a):
    a[i] = a[i] + 2

print(a)
print("")
print("========== How it's ACTUALLY done: ==========")
print("")

a = [2, 3]

for i in range(len(a)):
    a[i] = a[i] + 2

print(a)
