#include "pixelator.h"

////////////////////////////////////////////////////////////////

int main(){
  setup();

  do_tests();
  
  cleanup();
  return 0;
}

////////////////////////////////////////////////////////////////
// An array of pointers to ANSI test functions : 
////////////////////////////////////////////////////////////////
void do_tests(){

  void (*tests[])() = { *test_colors ,
			*test_colors2 };
  uint8_t numtests = sizeof(tests) / sizeof(tests[0]);
  
  for( int tsi=0 ; tsi!=numtests ; tsi++ ){
    tests[tsi]();
    delay(2);
    clear_term();
  }  
}

////////////////////////////////////////////////////////////////
void setup(){
  printf("Expanding UTF-8 to local conventions ...\n");
  setlocale(LC_ALL , "");
  //kill_canonical();
}

void cleanup(){
  //reset_canonical();
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
