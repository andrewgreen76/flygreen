/* All the functions using ANSI escape codes,
   including test functions. */

#include "ansi.h"

////////////////////////////////////////////////////////////////
void test_horsweep(){
  if(SHOW_TEST_MSGS){
    printf("Performing a left-to-right color sweep for animation simulation ...\n");
    delay(DLY_TICKS);
    clear_term();
  }

  // No tide @ 0 ; tide @ 1<->RES_WIDTH ; no tide @ RES_WIDTH+1. 
  for(int fr=0 ; fr<=RES_WIDTH+1 ; fr++){
    printf("\033[0m\033[H");
    
    for( int r=0 ; r<RES_HEIGHT/2 ; r++){ 
      // Trough : 
      if(fr>1) for(int lblues=(fr-1) ; lblues>0 ; lblues-- ) printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );
      // Wave : 
      if( fr>0 && fr<RES_WIDTH+1 ) printf( "\033[%d;%dm\u2580" , HI_TEA , LO_TEA );
      // Wave front : 
      for( int rblues=RES_WIDTH-fr ; rblues>0 ; rblues-- ) 
	printf( "\033[%d;%dm\u2580" , HI_BLU , LO_BLU );      
      
      printf("\n");
    }

    printf("\033[0mFrame : %d\n" , fr );
    if(ENDEBUG) delay(DLY_TICKS);
  }
  
}

////////////////////////////////////////////////////////////////
void test_vertsweep(){
  if(SHOW_TEST_MSGS){
    printf("Performing a top-down color sweep for animation simulation ...\n");
    delay(DLY_TICKS);
    clear_term();
  }

  for(int fr=0 ; fr<=RES_HEIGHT/2 ; fr++){
    printf("\033[0m\033[H");

    for( int r=0 ; r<RES_HEIGHT/2 ; r++){
      
    }    
  }  
  
}

////////////////////////////////////////////////////////////////
void test_palette2(){
  uint8_t ccode ; 

  if(SHOW_TEST_MSGS)  printf("Performing an extended color palette test ...\n");

  // 8 distinctive warm colors , 8 brighter ones : 
  for( ccode=0 ; ccode<16 ; ccode++ ) {
    if(ccode==8) { reset_colors(); printf("\n"); } 
    printf("\033[38;5;%d;48;5;%dm\u2580\u2580" , ccode , ccode ); 
  }
  reset_colors(); printf("\n"); 

  // 216-color palette : 
  for( ccode=16 ; ccode<232 ; ccode++ ) {
    if( !((ccode-16)%36) ) { reset_colors(); printf("\n"); }  
    printf("\033[38;5;%d;48;5;%dm\u2580\u2580" , ccode , ccode ); 
  }
  reset_colors(); printf("\n"); printf("\n"); 

  // Black-and-white : 
  for( ccode=232 ; ccode<255 ; ccode++ ) 
    printf("\033[38;5;%d;48;5;%dm\u2580\u2580" , ccode , ccode ); 
  reset_colors(); printf("\n"); 
  
  printf("[End of palette test 2]\n");
}
////////////////////////////////////////////////////////////////
void test_palette1(){  
  uint8_t ccode;
  
  if(SHOW_TEST_MSGS)  printf("Performing a basic 16-color palette test ...\n");
  
  // Native warm colors : 
  for( ccode = 30 ; ccode < 39 ; ccode++ )
    printf("\033[%d;5;226;%d;5;226m\u2580" , ccode , ccode+10 );    
    
  reset_colors();
  printf("[End of palette test 1]\n");
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
void reset_colors(){
  printf("\033[0m");  //printf("Restored character colors to default.\n");
  // system("tput sgr0");  -AND- fflush(stdout);  // // Make no difference => poor support of ANSI.
}

void clear_term(){
  reset_colors();
  printf("\033[2J");  //printf("Cleared the terminal with attributes in a full wraparound.\n");
  printf("\033[H");   //printf("Cleared the terminal with attributes, wrapping to origin.\n");
  // Or_simply_thi$: system("tput reset"); 
}
