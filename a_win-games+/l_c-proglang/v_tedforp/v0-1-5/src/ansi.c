/* All the functions using ANSI escape codes,
   including test functions. */

#include "ansi.h"


////////////////////////////////////////////////////////////////
void test_horsweep(){
  if(SHOW_TEST_MSGS){
    printf("Performing a horizontal color sweep for animation simulation ...\n");
    delay(DLY_TICKS);
    clear_term();
  }

  /************************************
  for(int fr = 0 ; fr<8 ; fr++){
    printf("\033[0m\033[H");
    for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // fr
      if(fr>1) for(int ) printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
      if(fr) printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
      for( fr=2 ; c<RES_WIDTH ; c++ ){
	printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
      }
      printf("\n");
    }
  }
  
  ************************************/
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 0
    for( int c=0 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 1
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=1 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 2
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=2 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 3
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=3 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 4
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=4 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 5
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=5 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 6
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=6 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 7
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
    for( int c=7 ; c<RES_WIDTH ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

}

////////////////////////////////////////////////////////////////
void test_resfade(){  
  if(SHOW_TEST_MSGS){
    printf("Performing a pseudo-fade test (for finest resolution) ...\n");
    delay(DLY_TICKS);
    clear_term();
  }
  
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 0
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 1
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }
  
  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 2
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_TEA );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 3a
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 3b
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_TEA );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){  // 4
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 3b
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_TEA );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 3a
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );      
    }
    printf("\n");
  }
  
  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 2
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_TEA );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 1
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_TEA , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }

  printf("\033[0m\033[H");
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){  // 0
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );
      printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
    }
    printf("\n");
  }
  
}

////////////////////////////////////////////////////////////////
void test_resgrain(){  
  if(SHOW_TEST_MSGS){
    printf("Performing a resolution granularity test ...\n");
    delay(DLY_TICKS);
    clear_term();
  }
  
  for( int r=0 ; r<RES_HEIGHT/2 ; r++){
    for( int c=0 ; c<RES_WIDTH/2 ; c++ ){
      printf( "\033[%d;%dm\u2580" , HI_RED , LO_WHT );
      printf( "\033[%d;%dm\u2580" , HI_WHT , LO_RED );      
    }
    printf("\n");
  }
}

////////////////////////////////////////////////////////////////
void test_palette(){  
  uint8_t ccode = 30;
  
  if(SHOW_TEST_MSGS){
    printf("Performing a color palette test ...\n");
  }
    
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
