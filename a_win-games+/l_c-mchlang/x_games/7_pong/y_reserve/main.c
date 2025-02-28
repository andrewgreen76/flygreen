#include <stdio.h>
#include <unistd.h>  // for ticking in microsecs.
#include <assert.h>  // for detecting segfaults. 

#define GRID_WIDTH 135
#define GRID_HEIGHT 37
#define REFLMARGTILE_CHAR '#'
#define PAD1TILE_CHAR 'H'
#define PAD2TILE_CHAR 'I'
#define BALL_CHAR 'O'
#define CLEAR_CHAR ' '
//
#define ASKED_FOR_NEWGAME 1
#define ASKED_TO_EXIT 2
#define WINLOSS 4

/* BSS/data */
unsigned char gridmem[GRID_WIDTH][GRID_HEIGHT];
unsigned char game_flags = ASKED_FOR_NEWGAME; 

/******************************************************/
/******************************************************/
/******************************************************/

void interst_freeze(){
  usleep(300000);
}

/******************************************************/
/******************************************************/
/******************************************************/

void init_margins(){
  for(int x=0 ; x<GRID_WIDTH ; x++)
    gridmem[x][0] = REFLMARGTILE_CHAR;
  for(int x=0 ; x<GRID_WIDTH ; x++)
    gridmem[x][GRID_HEIGHT-1] = REFLMARGTILE_CHAR;
}

/******************************************************/
/******************************************************/
/******************************************************/

void clear_fieldmem(){
  for(int y=1 ; y<GRID_HEIGHT-1 ; y++)
    for(int x=0 ; y<GRID_WIDTH ; x++)
      gridmem[x][y] = CLEAR_CHAR;
}

/******************************************************/
/******************************************************/
/******************************************************/

void print_gridmem(){
  for(int y=0 ; y<GRID_HEIGHT ; y++){
    for(int x=0 ; x<GRID_WIDTH ; x++){
      printf("%c" , gridmem[x][y]);
    }
    printf("\n");
  }
      
}

/******************************************************/
/******************************************************/
/******************************************************/

void check_for_sanit(){

  for(int y=0 ; y<GRID_HEIGHT ; y++)
    for(int x=0 ; x<GRID_WIDTH ; x++)
      assert( gridmem[x][y] ); // printf("Failed @ x=%d , y=%d\n" , x , y );
      
  /*
  unsigned char * checker = &gridmem;
  int counter = 0;
  while(*checker && counter<(GRID_WIDTH*GRID_HEIGHT) ) {
    checker++;
    counter++;
  }

  if(*checker != NULL){
    printf("All good.\n");
  }
  else printf("YOU FUCKED UP @ : %d" , counter);
  */  
}

/******************************************************/
/******************************************************/
/******************************************************/

int main(){

  // Setup / fixed parts : 
  init_margins();

  // Game logic loop : 
  while( !(game_flags & ASKED_TO_EXIT) ) {
    if( game_flags & ASKED_FOR_NEWGAME ){
      clear_fieldmem();
    }
    check_for_sanit();
    print_gridmem();
    interst_freeze();
    game_flags &= (ASKED_TO_EXIT ^ 0xff); 
  }
  
  return 0;
}
