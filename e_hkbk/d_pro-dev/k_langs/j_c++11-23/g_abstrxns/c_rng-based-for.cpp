#include <iostream>
#include <vector>

int main() {
    std::vector<int> numbers = {1, 2, 3, 4, 5};

    // Range-based for loop to iterate over the elements in the vector
    for (int num : numbers) {
        std::cout << num << " ";
    }

    std::cout << std::endl;

    return 0;
}
