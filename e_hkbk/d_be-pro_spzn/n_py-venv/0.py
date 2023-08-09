for x in range(100):
    for y in range(100):
        #print('x: ', x)
        #print('y: ', y)
        print(x and y and (x in y) and (y in x) and (x[0] == y[-1]))
        #print(f"{x and y and (x in y) and (y in x) and (x[0] == y[-1])}")
