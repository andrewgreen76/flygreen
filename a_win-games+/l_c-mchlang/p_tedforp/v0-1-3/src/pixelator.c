#include "pixelator.h"

////////////////////////////////////////////////////////////////

int main(){
  setup();
  
  test_colors();
  delay(1);

  cleanup();
  return 0;
}

////////////////////////////////////////////////////////////////

void setup(){
  printf("Expanding UTF-8 to local conventions ...\n");
  setlocale(LC_ALL , ""); 
}

void cleanup(){
  reset_colors();
}

void kill_canonical(){
  tcgetattr(STDIN_FILENO , &term_can);      // get_termst0() and preserve_termst0();
  term_nocan = term_can;                       // init_termst1();
  term_nocan.c_lflag &= ~(ICANON | ECHO);        // mod_termst1();
  tcsetattr(STDIN_FILENO, TCSANOW, &term_nocan); // load_termst1();
}

void reset_canonical(){
  tcsetattr(STDIN_FILENO, TCSANOW, &term_can);
}
