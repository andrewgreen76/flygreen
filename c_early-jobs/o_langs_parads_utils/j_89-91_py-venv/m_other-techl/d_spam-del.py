class Spam:
    def __del__(self):
        print("Deleted!")

x = Spam()
y = x
del x
