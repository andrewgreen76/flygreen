#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

#define ENABLE_PRINTDEBUG 0
#define GRID_WIDTH 135
#define GRID_HEIGHT 37
#define SNAKE_MAXLOGSIZE 600

int stdin_ch = 0; 
char gridmem[GRID_WIDTH][GRID_HEIGHT];

struct Coordinate {
  int x , y;
};

struct SnakeType {
  // Limited record for the snake's whereabouts - in a [600max] * [x,y] array instead of a dynamic data structure : 
  struct Coordinate traillog[SNAKE_MAXLOGSIZE];
  int frontcoord_logind; // = 2;
  int rearcoord_logind; // = 0;
  char headdir; // = 'u';
};
struct SnakeType snake;

/******************************************************************/
/******************************************************************/
/******************************************************************/

int get_stdin_char(void) {
  struct termios oldt, newt;
  int oldf;

  // Disable canonical mode / buffered read : 
  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO); 
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
  fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

  // stdin populated (or not) before landing getchar() one char at a time. 
  stdin_ch = getchar();

  // Enable canonical mode : 
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);

  if(stdin_ch != EOF) return 1;    // ch=/=-1 => Was pressed.
  
  return 0;
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int react_to_key(){

  int asked_to_exit = 0;
  
  sleep(1);  // Take 1s to register key input.
  
  if (get_stdin_char()) {
    if(stdin_ch==27) {
      //printf("E");   // Give esc.seq a char to eat. 

      get_stdin_char();
      // An esc.seq ? 
      if(stdin_ch==91){

	get_stdin_char();
	// Which arrow ? 
	switch(stdin_ch) { 
	case 65:
	  snake.headdir = 'u';
	  if (ENABLE_PRINTDEBUG) printf("UP-ARROW PRESSED\n");
	  break;
	case 66:
	  snake.headdir = 'd';
	  if (ENABLE_PRINTDEBUG) printf("DOWN-ARROW PRESSED\n");
	  break;
	case 67:
	  snake.headdir = 'r';
	  if (ENABLE_PRINTDEBUG) printf("RIGHT-ARROW PRESSED\n");
	  break;
	case 68:
	  snake.headdir = 'l';
	  if (ENABLE_PRINTDEBUG) printf("LEFT-ARROW PRESSED\n");
	  break;
	}
      }
      
      else asked_to_exit = 1;  
    }
  }

  return asked_to_exit; 
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void clear_screen(){
  printf("\033[H\033[J");
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void init_gridmem(){
  
  int x , y;
  // The snake's blank space : 
  for(y=1 ; y<GRID_HEIGHT-1 ; y++)
    for(x=1 ; x<GRID_WIDTH-1 ; x++)
      gridmem[x][y] = ' ';

  // The corners :
  gridmem[0][0] =                        '#';
  gridmem[GRID_WIDTH-1][0] =             '#';
  gridmem[0][GRID_HEIGHT-1] =            '#';
  gridmem[GRID_WIDTH-1][GRID_HEIGHT-1] = '#';

  // The sides :
  for(x=1 ; x<GRID_WIDTH-1 ; x++) gridmem[x][0] =             '#';
  for(x=1 ; x<GRID_WIDTH-1 ; x++) gridmem[x][GRID_HEIGHT-1] = '#';
  for(y=1 ; y<GRID_HEIGHT-1 ; y++) gridmem[0][y] =            '#';
  for(y=1 ; y<GRID_HEIGHT-1 ; y++) gridmem[GRID_WIDTH-1][y] = '#';   
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void print_gridmem(){
  for(int y=0 ; y<GRID_HEIGHT ; y++) {
    for(int x=0 ; x<GRID_WIDTH ; x++)
      printf("%c" , gridmem[x][y]);
    printf("\n");
  }
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void plan_snakespecs(){
  snake.traillog[2].x = GRID_WIDTH/2;
  snake.traillog[2].y = GRID_HEIGHT/2;
  snake.traillog[1].x = GRID_WIDTH/2;
  snake.traillog[1].y = GRID_HEIGHT/2 + 1;
  snake.traillog[0].x = GRID_WIDTH/2;
  snake.traillog[0].y = GRID_HEIGHT/2 + 2;
  //
  snake.frontcoord_logind = 2;
  snake.rearcoord_logind = 0;
  //
  snake.headdir = 'u';
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void populate_snake2gridmem(){
  //gridmem[][] = '*';
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void init_game(){
  init_gridmem();
  plan_snakespecs();
  populate_snake2gridmem();
  // put_food
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int main() {

  int asked_to_exit = 0 , newgame_reason = 1;
  
  // Game loop.
  // Assume the calls below can be made in any order , but this order in particular seems the fairest. 
  while(!asked_to_exit) {
    if(newgame_reason) {
      init_game();
      newgame_reason = 0;
    }
    clear_screen();
    print_gridmem();
    asked_to_exit = react_to_key();
    //advance_gamestate();
    //newgame_reason = check_headcollision();
  }
  
  clear_screen();
  return 0;
}
