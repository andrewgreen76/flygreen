#include <stdio.h>

#define DEBUG  // Uncomment this line to enable debug mode

int main() {
    int value = 10;

#ifdef DEBUG
    printf("Debug mode is enabled!\n");
    printf("The value is: %d\n", value);
#endif

    // Rest of the code...

    return 0;
}
