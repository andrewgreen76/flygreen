text = "Python is amazing!"
if text.find("C++"):
    print("Found C++!")
else:
    print("C++ not found!")

# Yet text.find() returned -1. and text.find() is a Python function. text.find() would return index=-1 meaning "not found". Should have been: 
#
# if(text.find(__)==-1) print("not found")
# else:
#    print ("found")
