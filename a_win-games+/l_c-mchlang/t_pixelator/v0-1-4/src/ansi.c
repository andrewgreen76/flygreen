/* All the functions using ANSI escape codes,
   including test functions. */

#include "ansi.h"

////////////////////////////////////////////////////////////////
void test_320x240(){  
  uint8_t clref = 30;
  
  printf("Performing a color test on the terminal (for finest resolution) ...\n");
  delay(DLY_TICKS);
  clear_term();

  for( int r=0 ; r<RES_HEIGHT/2 ; r++){
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_WHT , LO_GLD );
      printf( "\033[%d;%dm\u2580" , HI_GLD , LO_WHT );      
    }
    printf("\n");
  }

  clear_term();

  for( int r=0 ; r<RES_HEIGHT/2 ; r++){
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_GLD , LO_WHT );
      printf( "\033[%d;%dm\u2580" , HI_WHT , LO_GLD );      
    }
    printf("\n");
  }

  clear_term();

  for( int r=0 ; r<RES_HEIGHT/2 ; r++){
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_WHT , LO_GLD );
      printf( "\033[%d;%dm\u2580" , HI_GLD , LO_WHT );      
    }
    printf("\n");
  }

  clear_term();

  for( int r=0 ; r<RES_HEIGHT/2 ; r++){
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_GLD , LO_WHT );
      printf( "\033[%d;%dm\u2580" , HI_WHT , LO_GLD );      
    }
    printf("\n");
  }
  
}

////////////////////////////////////////////////////////////////
void test_palette(){  
  uint8_t ccode = 30; 
  printf("Performing a colored characters display test ...\n");
  
  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ )
    printf("\033[%d;%dm\u2580" , ccode , ccode+10 );
  reset_colors();
  printf("[EOTEST]\n");
  //fflush(stdout);  // Enforce immediate print of stdout to terminal. 
}

////////////////////////////////////////////////////////////////
void reset_colors(){
  printf("\033[0m");  //printf("Restored character colors to default.\n");
}

void clear_term(){
  reset_colors();
  printf("\033[2J");  //printf("Cleared the terminal with attributes in a full wraparound.\n");
  printf("\033[H");   //printf("Cleared the terminal with attributes, wrapping to origin.\n");
  // Or_simply_thi$: system("tput reset"); 
}
