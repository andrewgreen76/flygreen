#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <stdbool.h>

#define ENABLE_PRINTDEBUG 0
#define MICROSECS 400000
#define SNAKE_MAXTRAILLEN 600
//
// "Error : const is not a compile-time constant for array sizes."
#define SNAKE_CHAR 'S'
#define FOOD_CHAR 'Q'
#define GRID_WIDTH 22
#define GRID_HEIGHT 17
char gridmem[GRID_WIDTH][GRID_HEIGHT];

int stdin_ch = 0; 

struct Coordinate {
  int x , y;
};

// Idea : a very long log-array with room for past, present, and future snake pieces. 
//  . a limited record for the snake's whereabouts - in a [600max]*[x,y] array instead of a dynamic data structure :
//  . i.e. , an array of {x,y}'s 
struct Coordinate trail[SNAKE_MAXTRAILLEN];
int frontxy_i; // = 2;
int rearxy_i; // = 0;
char curdir = 'u';
char givendir = 'u'; 

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
	  givendir = 'u';
	  if (ENABLE_PRINTDEBUG) printf("UP-ARROW PRESSED\n");
	  break;
	case 66:
	  givendir = 'd';
	  if (ENABLE_PRINTDEBUG) printf("DOWN-ARROW PRESSED\n");
	  break;
	case 67:
	  givendir = 'r';
	  if (ENABLE_PRINTDEBUG) printf("RIGHT-ARROW PRESSED\n");
	  break;
	case 68:
	  givendir = 'l';
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
  rearxy_i = 0;
  frontxy_i = 2;
  //
  // Rear to front : 
  trail[rearxy_i].x = GRID_WIDTH/2;
  trail[rearxy_i].y = GRID_HEIGHT/2 + 2;
  //
  trail[1].x = GRID_WIDTH/2;
  trail[1].y = GRID_HEIGHT/2 + 1;
  //
  trail[frontxy_i].x = GRID_WIDTH/2;
  trail[frontxy_i].y = GRID_HEIGHT/2;
  //
  curdir = 'u';
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

// Map snake pieces by coords (from rear to front) :

void populate_snake2gridmem(){
  
  int x , y ;

  for(int piece_i = rearxy_i ;
      piece_i <= frontxy_i ;
      piece_i++)
  {
    x = trail[piece_i].x;
    y = trail[piece_i].y;
    gridmem[x][y] = SNAKE_CHAR;
  }
  
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int get_constrrand(int constrain)
{
  int randum = rand() % constrain;  
  //if(ENABLE_PRINTDEBUG) printf("Generated : %d\n" , randum);
  
  return randum;
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void populate_food(){

  int 
    interm_x_found = 0 , 
    interm_y_found = 0 , 
    blankchar_spotted = 0
    ;

  while(!blankchar_spotted){
    // Generated rands are expected to be positive (filtering out top and left margins)
    // => will serve as their own positive-found flags : 
    while(!interm_x_found) interm_x_found = get_constrrand(GRID_WIDTH);  // Lock in on x.
    while(!interm_y_found) interm_y_found = get_constrrand(GRID_HEIGHT); // Lock in on y ... and check gridchar validity.
  
    if(gridmem[interm_x_found][interm_y_found] == ' '){
      gridmem[interm_x_found][interm_y_found] = FOOD_CHAR;
      blankchar_spotted = 1;  // Success. 
    }
    else{  // Fail : clear rands as flags :
      // blankchar_spotted = 0; 
      interm_x_found = 0;
      interm_y_found = 0;
    }
  }
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void init_game(){
  init_gridmem();
  plan_snakespecs();
  populate_snake2gridmem();
  populate_food();
}


/********************************************************************/
/********************************************************************/
/********************************************************************/

void set2givendir(){
  
  // ... with a constraint for an obvious reason :
  if(curdir=='u' && givendir!='d'
     || curdir=='d' && givendir!='u'
     || curdir=='l' && givendir!='r'
     || curdir=='r' && givendir!='l')
    curdir = givendir;  
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void spec_newhead(){
    
  // ... at every tick : 
  if(curdir == 'u'){
    trail[frontxy_i].x = trail[ frontxy_i-1 ].x; 
    trail[frontxy_i].y = trail[ frontxy_i-1 ].y - 1;
  }      
  if(curdir == 'd'){
    trail[frontxy_i].x = trail[ frontxy_i-1 ].x; 
    trail[frontxy_i].y = trail[ frontxy_i-1 ].y + 1;
  }      
  if(curdir == 'l'){
    trail[frontxy_i].x = trail[ frontxy_i-1 ].x - 1; 
    trail[frontxy_i].y = trail[ frontxy_i-1 ].y;
  }      
  if(curdir == 'r'){
    trail[frontxy_i].x = trail[ frontxy_i-1 ].x + 1; 
    trail[frontxy_i].y = trail[ frontxy_i-1 ].y;
  }
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

void handle_food(){
      
  if( gridmem[ trail[frontxy_i].x ][ trail[frontxy_i].y ] != FOOD_CHAR ){ 
    gridmem[ trail[rearxy_i].x ][ trail[rearxy_i].y ] = ' ';  
    rearxy_i++; 
  } // ... that is , let the tail advance upon NOT eating at this tick-interval. 
  else populate_food();
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int handle_collw_marg() {
  
  return (trail[frontxy_i].x == 0
	  || trail[frontxy_i].x == GRID_WIDTH-1
	  || trail[frontxy_i].y == 0
	  || trail[frontxy_i].y == GRID_HEIGHT-1)
    ? 1 : 0;
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int handle_collw_self() {

  int steptile_x = trail[frontxy_i].x;
  int steptile_y = trail[frontxy_i].y;
  return ( curdir=='u' && gridmem[steptile_x][steptile_y]==gridmem[steptile_x][steptile_y+1]
	   || curdir=='d' && gridmem[steptile_x][steptile_y]==gridmem[steptile_x][steptile_y-1]
	   || curdir=='l' && gridmem[steptile_x][steptile_y]==gridmem[steptile_x+1][steptile_y]
	   || curdir=='r' && gridmem[steptile_x][steptile_y]==gridmem[steptile_x-1][steptile_y]
	   )
    ? 1 : 0;
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int advance_snakeinmem(){
  
  // Inform of a new HEAD piece : 
  frontxy_i++;
  
  set2givendir();
  spec_newhead();
  // We have ***NOT*** populated the new head to the gridmem yet.
  // This is an opportunity to do some checks before the populating. 
  handle_food();
  if( handle_collw_marg() ) return 1;
  if( handle_collw_self() ) return 1;
  
  // No hindrances => let the head "advance" :
  gridmem[ trail[frontxy_i].x ][ trail[frontxy_i].y ] = SNAKE_CHAR;

  return 0;
}

/********************************************************************/
/********************************************************************/
/********************************************************************/

int main() {

  srand(time(NULL));
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
    usleep(MICROSECS);  // TIME TO PROTRACT every state - to display the state ... and give player time to think.
    asked_to_exit = react_to_key(); 
    newgame_reason = advance_snakeinmem(); // Includes food-eating logic. 
                                           // Includes collision-for-loss logic. 
  }
  
  clear_screen();
  //system("clear ; ls -1");
  return 0;
}
