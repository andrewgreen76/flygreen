
#include <stdio.h>

int main() {
  int ch;

  printf("Enter text (Ctrl+D to end):\n");

  // Two states for the process to linger in : `getc(stdin)` and `while`. 
  while ((ch = getc(stdin)) != EOF) { // Read one character at a time
    putc(ch, stdout); // Print the character
  }

  return 0;
}



/*
Yes, pressing `Ctrl+D` (on Unix-like systems) generates an EOF (end-of-file) signal for standard input. This indicates that there is no more data to be read, and functions like `getchar()` or `getc()` will return `EOF` when this signal is encountered.
*/
