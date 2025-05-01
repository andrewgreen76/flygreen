#include <stdio.h>
#include <unistd.h>
#include <termios.h>

struct termios termst0; 

////////////////////////////////////////////////////////

void set_noncanon(){
  struct termios termst1; 

  tcgetattr(STDIN_FILENO , &termst0);      // get_termst0() and preserve_termst0();
  termst1 = termst0;                       // init_termst1();
  termst1.c_lflag &= ~(ICANON | ECHO);        // mod_termst1();
  tcsetattr(STDIN_FILENO, TCSANOW, &termst1); // load_termst1();
}

void restore_canon(){
  tcsetattr(STDIN_FILENO, TCSANOW, &termst0);
}

////////////////////////////////////////////////////////

void main(){
  //
  set_noncanon();

  //
  
  restore_canon();
}
