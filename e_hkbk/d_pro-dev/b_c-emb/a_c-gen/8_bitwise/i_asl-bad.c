#include <stdio.h>

int main() {
    int value = 10;
    
    // Invalid shift by a value greater than or equal to the width of int
    int invalidShift = value << 32;  // Shift by 32 bits
    
    printf("Invalid shift result: %d\n", invalidShift);
    
    return 0;
}
