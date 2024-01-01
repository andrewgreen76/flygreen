#include <stdio.h>

int main() {
    char inputString[100]; // Assuming a maximum string length of 99 characters

    printf("Enter a string: ");
    // Using %99s to limit the input to 99 characters to avoid buffer overflow
    if (scanf("%99s", inputString) == 1) {
        // Successfully read the string
        printf("You entered: %s\n", inputString);
    } else {
        // Handle input error
        printf("Error reading input.\n");
    }

    return 0;
}
