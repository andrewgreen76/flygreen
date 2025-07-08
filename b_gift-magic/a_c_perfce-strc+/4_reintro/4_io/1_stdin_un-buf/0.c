#include <stdio.h>
#include <unistd.h>
#include <termios.h>

struct termios term_canon , term_noncanon;

void set_raw_mode() {
  
  tcgetattr(STDIN_FILENO, &term_canon);
  term_noncanon = term_canon;
  term_noncanon.c_lflag &= ~(ICANON | ECHO); // Disable canonical mode and echo
  tcsetattr(STDIN_FILENO, TCSANOW, &term_noncanon);
}

int main() {
  char ch;

  set_raw_mode(); // Set terminal to raw mode
  printf("Press any key (Press 'q' to quit): ");

  while (1) {
    ch = getchar(); // Read a single character
    printf("\nYou pressed: '%c'. Again: ", ch);
    if (ch == 'q') break; // Exit on 'q'
  }

  tcsetattr(STDIN_FILENO , TCSANOW , &term_canon);

  return 0;
}
