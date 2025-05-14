
// This is similar to waitkey_timed.c but with `while()` in place of `for()`. 

#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>


int kbhit() {
  struct termios oldt, newt;
  int oldf;

  tcgetattr(0, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(0, TCSANOW, &newt);
  oldf = fcntl(0, F_GETFL, 0);
  fcntl(0, F_SETFL, oldf | O_NONBLOCK);

  int ch = getchar();

  tcsetattr(0, TCSANOW, &oldt);
  fcntl(0, F_SETFL, oldf);

  if(ch != EOF) {
    ungetc(ch, stdin);
    return 1;
  }

  return 0;
}


int main() {
  while (!kbhit());

  return 0;
}
