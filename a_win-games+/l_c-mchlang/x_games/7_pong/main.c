#include <stdio.h>
#include <unistd.h>  // for ticking in microsecs.
#include <assert.h>  // spits out meaningless error messages. 

#define ENABLE_PRINTDBG 0
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

/******************************************************/
/******************************************************/
/******************************************************/

void interst_freeze(){
  usleep(300000);
}

/******************************************************/
/******************************************************/
/******************************************************/

void init_margins(unsigned char (*gridmem)[GRID_HEIGHT] ){

  if(ENABLE_PRINTDBG) printf("Populating reflective margins ...\n");
  
  for(int x=0 ; x<GRID_WIDTH ; x++)
    *gridmem[x][0] = REFLMARGTILE_CHAR;
  for(int x=0 ; x<GRID_WIDTH ; x++)
    *gridmem[x][GRID_HEIGHT-1] = REFLMARGTILE_CHAR;

  if(ENABLE_PRINTDBG) printf("Reflective margins populated.\n");
}

/******************************************************/
/******************************************************/
/******************************************************/

void clear_fieldmem(unsigned char (*gridmem)[GRID_HEIGHT] ){

  if(ENABLE_PRINTDBG) printf("Sanitizing the field ...\n");

  for(int y=1 ; y<GRID_HEIGHT-1 ; y++)
    for(int x=0 ; x<GRID_WIDTH ; x++)
      *gridmem[x][y] = CLEAR_CHAR;

  if(ENABLE_PRINTDBG) printf("Field sanitized.\n");
}

/******************************************************/
/******************************************************/
/******************************************************/

void print_gridmem(unsigned char (*gridmem)[GRID_HEIGHT] ){

  if(ENABLE_PRINTDBG) printf("Printing the entire grid ...\n");
  
  for(int y=0 ; y<GRID_HEIGHT ; y++){
    for(int x=0 ; x<GRID_WIDTH ; x++){
      printf("%c" , *gridmem[x][y]);
    }
    printf("\n");
  }
      
  if(ENABLE_PRINTDBG) printf("Entire grid printed.\n");
}

/******************************************************/
/******************************************************/
/******************************************************/

int main(){

  unsigned char gridmem[GRID_WIDTH][GRID_HEIGHT];
  unsigned char game_flags = ASKED_FOR_NEWGAME; 

  // Setup / fixed parts : 
  init_margins(gridmem);

  // Game logic loop : 
  while( !(game_flags & ASKED_TO_EXIT) ) {
    if( game_flags & ASKED_FOR_NEWGAME ){
      clear_fieldmem(gridmem);
      game_flags &= (ASKED_FOR_NEWGAME ^ 0xff);       
    }
    print_gridmem(gridmem);
    
    //game_flags |= ASKED_TO_EXIT; 
    interst_freeze();
  }
  
  return 0;
}
