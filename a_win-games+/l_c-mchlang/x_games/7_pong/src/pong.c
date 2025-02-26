#include <stdio.h>
#include <termios.h>  // for non-canonical reading of stdin. 
#include <time.h>     // for random number generation. 

#define ENABLE_PRINTDEBUG 0
#define ASKED_TO_EXIT 1
#define NEWGAME_REASON 2
#define FRAME_USECS 300000
//
#define GRID_WIDTH 135
#define GRID_HEIGHT 37
#define MARGIN_CHAR = '#'
#define HOMEPADDLE_CHAR = 'H'
#define VISITORPADDLE_CHAR = 'R'
#define BALL_CHAR = 'O'

char grid[GRID_WIDTH][GRID_HEIGHT];  // EXPORT TO ANOTHER FILE. 

/******************************************************************/
/******************************************************************/
/******************************************************************/

int main(){

  unsigned char game_flags = 0;
    
  /*  
  while(!asked_to_exit) {
    if(newgame_reason) {
      init_game();
      newgame_reason = 0;
    }
    clear_screen();
    print_gridmem();
    usleep(MICROSECS);  // TIME TO PROTRACT every state - to display the state ... and give player time to think.
    asked_to_exit = react_to_key(); 
    newgame_reason = advance_snakeinmem(); // Includes food-eating logic. 
                                           // Includes collision-for-loss logic. 
  }
  */

  return 0;
}
