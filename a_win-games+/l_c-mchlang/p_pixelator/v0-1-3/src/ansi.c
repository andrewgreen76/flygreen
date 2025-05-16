#include "ansi.h"

void reset_colors(){
  printf("\033[0m"); 
  fflush(stdout);  // Manual flush in place of an extra line feed doing the flush. 
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


////////////////////////////////////////////////////////////////
void test_colors2(){  
  uint8_t clref = 30; 
  printf("Performing a color test on shell-as-canvas at finer resolution ...\n");

  for( int r=0 ; r<RES_HEI/2 ; r++)
    for( int c=0 ; c<RES_WID ; c++ ){
      //
    }
  
  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ )
    printf("\033[%d;%dm\u2580" , ccode , ccode+10 );
  printf("\033[0m[EOTEST]");
  fflush(stdout);  // Enforce immediate print of stdout to terminal. 
}
