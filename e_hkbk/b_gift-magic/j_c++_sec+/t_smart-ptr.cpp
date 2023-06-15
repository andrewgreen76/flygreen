#include <iostream>
#include <memory>

class MyClass {
public:
    MyClass() {
        std::cout << "Constructor called" << std::endl;
    }

    ~MyClass() {
        std::cout << "Destructor called" << std::endl;
    }

    void doSomething() {
        std::cout << "Doing something" << std::endl;
    }
};

int main() {
    std::unique_ptr<MyClass> myPtr = std::make_unique<MyClass>();

    myPtr->doSomething();

    // No need to manually delete the object, it is automatically released

    return 0;
}
