class Run:
    def __init__(self):
        self.__miles = 7
        self.races = 5

    def run(self):
        if self.__miles == 7:
            return self.__miles
        self.races = 6
        return self.__miles * self.races


t = Run()
t._Run__miles = 5
print(t.run())
