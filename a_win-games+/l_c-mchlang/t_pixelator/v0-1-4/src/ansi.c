#include "ansi.h"

void reset_colors(){
  printf("\033[0m");  printf("Restored character colors to default.\n");
}

void clear_term(){
  reset_colors();
  printf("\033[2J");  printf("Cleared terminal with attributes in a full wraparound.\n");
  printf("\033[H");   printf("Cleared terminal with attributes, wrapping to origin.\n");
  // Or_simply_thi$: system("tput reset"); 
}

////////////////////////////////////////////////////////////////
void test_palette(){  
  uint8_t ccode = 30; 
  printf("Performing a colored characters display test ...\n");
  
  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ )
    printf("\033[%d;%dm\u2580" , ccode , ccode+10 );
  printf("\033[0m[EOTEST]");
  fflush(stdout);  // Enforce immediate print of stdout to terminal. 
}


////////////////////////////////////////////////////////////////
void test_320x240(){  
  uint8_t clref = 30; 
  //printf("Performing a color test on shell-as-canvas at finer resolution ...\n");

  printf( "\033[%d;%dm\u2580" , HI_RED , LO_RED );
  //
  fflush(stdout);
  
  /*
  for( int r=0 ; r<RES_HEI/2 ; r++){
    for( int c=0 ; c<RES_WID ; c++ ){
      //
    }
  }
  
  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ )
    printf("\033[%d;%dm\u2580" , ccode , ccode+10 );
  printf("\033[0m[EOTEST]");
  fflush(stdout);  // Enforce immediate print of stdout to terminal.
  */
  
}
