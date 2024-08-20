#include <stdio.h>

int main() {
    int a = INT_MAX;  // Maximum value for an 'int'
    int b = 1;
    int result = a + b;  // Integer overflow occurs here

    printf("Result: %d\n", result);
    return 0;
}
