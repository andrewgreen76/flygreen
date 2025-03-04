#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

#define GRID_WIDTH 22
#define GRID_HEIGHT 17
#define SNAKE_INITLEN 3

/********************************************************************/
/********************************************************************/
/********************************************************************/

void populate_margins(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void clear_fieldmem(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void create_snakelog(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void fill_snakelog(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void determine_headdir(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void populate_newsnake(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void determine_foodloc(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void populate_food(){
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void reset_gridmem(){
  clear_fieldmem();
  //
  create_snakelog();
  fill_snakelog();
  determine_headdir();
  populate_newsnake();
  //
  determine_foodloc();
  populate_food();
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void reset_game(){
  reset_gridmem();
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void print_gridmem(){
  // Has everything : margins , blank field , snake , food.
  
  // Sleep for some time to give the player time to respond. 
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void check_headcollision(){
  // Bunch of if's for collision with margins => loss => reset_game(). 
  // An if for collision with a body part     => loss => reset_game(). 
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void react_to_key(){
  // Bunch of if's for escape sequences => change of headdir. 
  // Regular 'ESC' and 'q' will raise the flag to exit the game. 
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void advance_gamestate(){
  // Check if [[head.x==food.x]] && [[head.y==food.y]] => EATEN flag raised.
  // Else pass. 
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int main() {
  
  populate_margins();
  reset_game();

  // Game loop. Could the calls below be made in any order ? 
  while(1) {
    print_gridmem();
    check_headcollision();
    react_to_key();
    advance_gamestate();
  }

  return 0;
}
