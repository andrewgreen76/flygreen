#include <stdio.h>

int main() {
    char buffer[5];
    printf("Enter a string: ");
    gets(buffer); // Unsafe function that can cause buffer overflow
    printf("You entered: %s\n", buffer);
    
    return 0;
}
