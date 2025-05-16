#include "ansi.h"

void reset_colors(){
  printf("\033[0m\n"); 
  printf("Restored character colors to default.\n");
}

void clear_term(){
  printf("\033[2J\033[H");
}

////////////////////////////////////////////////////////////////
void test_colors(){  
  uint8_t ccode = 30; 
  printf("Performing a colored characters display test ...\n");
  
  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ )
    printf("\033[%d;%dm\u2580" , ccode , ccode+10 );
  printf("\033[0m[EOTEST]");
  fflush(stdout);  // Enforce immediate print of stdout to terminal. 
}

