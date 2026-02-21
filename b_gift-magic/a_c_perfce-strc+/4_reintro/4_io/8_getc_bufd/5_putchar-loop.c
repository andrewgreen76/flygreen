#include <stdio.h>

int main() {
    int ch;

    printf("Enter text (Ctrl+D to end):\n");

    while ((ch = getc(stdin)) != EOF) { // Read one character at a time
        putchar(ch); // Print the character
    }

    return 0;
}
