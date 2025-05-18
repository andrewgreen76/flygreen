#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

int kbhit(void) {
  struct termios oldt, newt;
  int ch , oldf;

  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO); 
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
  fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

  ch = getchar();

  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);

  if(ch != EOF) {    // Was pressed.
    ungetc(ch, stdin);
    printf("This is your character : %c\n" , ch);
    return 1;
  }
  
  return 0;
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void read_key(){

  int t=0;
  
  while (!kbhit()) {
    sleep(1);  // Sleep for 1s 
    t++;
    printf("Tick : %d\n" , t);
  }
  
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

int main() {

  read_key();
  
  return 0;
}
