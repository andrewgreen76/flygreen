#include <stdio.h>
#include <string.h>

int main() {
    char str[10];  // Declare a character array to hold the string

    strcpy(str, "Hello");  // Initialize the string using strcpy

    printf("String: %s\n", str);  // Output the initialized string

    return 0;
}
