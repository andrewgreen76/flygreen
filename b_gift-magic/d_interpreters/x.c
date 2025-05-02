#include <stdio.h>
#include <unistd.h>

struct termios termst0;

void set_noncanon(){
  tcgetattr(); // get_termst0();
  // save_termst0();
  // init_termst1();
  // mod_termst1();
  // load_termst1();
}

void restore_canon(){
  restore_termst0();
}

void main(){
  //

}
