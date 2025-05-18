#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

#define ENABLE_PRINTDEBUG 0
#define GRID_WIDTH 135
#define GRID_HEIGHT 37

int stdin_ch = 0; 
char dir = 'u';
char gridmem[GRID_WIDTH][GRID_HEIGHT]; 

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
	  dir = 'u';
	  if (ENABLE_PRINTDEBUG) printf("UP-ARROW PRESSED\n");
	  break;
	case 66:
	  dir = 'd';
	  if (ENABLE_PRINTDEBUG) printf("DOWN-ARROW PRESSED\n");
	  break;
	case 67:
	  dir = 'r';
	  if (ENABLE_PRINTDEBUG) printf("RIGHT-ARROW PRESSED\n");
	  break;
	case 68:
	  dir = 'l';
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

int main() {

  int perm_to_exit = 0;
  init_gridmem(); 
  
  // Game loop.
  // Assume the calls below can be made in any order , but this order in particular seems the fairest. 
  while(!perm_to_exit) {
    clear_screen();
    print_gridmem();
    perm_to_exit = react_to_key();
    //advance_gamestate();
    //check_headcollision();
  }
  
  clear_screen();
  return 0;
}
