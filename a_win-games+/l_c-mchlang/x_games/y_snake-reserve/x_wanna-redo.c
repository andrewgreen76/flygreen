#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>
#include <wchar.h>
#include <locale.h>

#define ENABLE_PRINTDEBUG 0
//
#define GRID_WIDTH 22
#define GRID_HEIGHT 17
#define SNAKE_STARTLEN 3

/* Global pass-alongs to avoid unwieldy local pass-arounds : */
int ch = 0; 
int good_to_exit = 0;
//char dir = 'u';
//wchar_t grid[GRID_WIDTH][GRID_HEIGHT];

struct PieceType {
  int x , y;
};

struct SnakeType {
  struct PieceType * head; 
  char dir = 'u';
  struct PieceType * tail;
};

struct GamespaceType {
  wchar_t grid[GRID_WIDTH][GRID_HEIGHT];  
  struct SnakeType snake_qlog;  // Will keep track of the snake's whereabouts. 
  struct PieceType food;
};

struct GamespaceType gamespace;

/******************************************************************/
/******************************************************************/
/******************************************************************/

void wipe_screen(){
  wprintf(L"\033[H\033[J");
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void redraw_gridbox(){
  
  for(int y=0 ; y<GRID_HEIGHT ; y++) {
    for(int x=0 ; x<GRID_WIDTH ; x++) wprintf(L"%lc" , grid[x][y]);
    wprintf(L"\n");
  }
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void redraw_all(){
  if (ENABLE_PRINTDEBUG) printf("Re-displaying all ...\n");

  wipe_screen();
  redraw_gridbox();
  //redraw_snake();
  //redraw_food();
  
  if (ENABLE_PRINTDEBUG) printf("Re-displayed all.\n");
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void assess_snakehead(){
  if (ENABLE_PRINTDEBUG) printf("Testing for head collision ...\n");
  if (ENABLE_PRINTDEBUG) printf("Tested for head collision.\n");
}

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
  ch = getchar();
  //printf("NEXT CHAR : %c" , ch);
  //
  // Esc_char = \n + eats next output char ; need a hack : 
  //if(ch!=27) printf("\n");

  // Enable canonical mode : 
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);

  if(ch != EOF) return 1;    // ch=/=-1 => Was pressed.
  
  return 0;
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void react_to_key(){

  if (ENABLE_PRINTDEBUG) printf("Awaiting key input ...\n");
  sleep(1);  // Take 1s to register key input.
  
  if (get_stdin_char()) {
    if(ch==27) {
      //printf("E");   // Give esc.seq a char to eat. 

      get_stdin_char();
      // An esc.seq ? 
      if(ch==91){

	get_stdin_char();
	// Which arrow ? 
	switch(ch) { 
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
      
      else good_to_exit = 1;  
    }
  }
  
  if (ENABLE_PRINTDEBUG) printf("Handled key input.\n");
  
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void advance_gamestate(){
  if (ENABLE_PRINTDEBUG) printf("Advancing game state ...\n");
  if (ENABLE_PRINTDEBUG) printf("Advanced game state.\n");
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void init_gridbox(){
  int x , y;

  // The blank within the gridbox : 
  for(y=1 ; y<GRID_HEIGHT-1 ; y++)
    for(x=1 ; x<GRID_WIDTH-1 ; x++)
      grid[x][y] = L' ';

  // The corners :
  grid[0][0] =                        L'\u2554';
  grid[GRID_WIDTH-1][0] =             L'\u2557';
  grid[0][GRID_HEIGHT-1] =            L'\u255A';
  grid[GRID_WIDTH-1][GRID_HEIGHT-1] = L'\u255D';

  // The sides :
  for(x=1 ; x<GRID_WIDTH-1 ; x++) grid[x][0] =             L'\u2550';
  for(x=1 ; x<GRID_WIDTH-1 ; x++) grid[x][GRID_HEIGHT-1] = L'\u2550';
  for(y=1 ; y<GRID_HEIGHT-1 ; y++) grid[0][y] =            L'\u2551';
  for(y=1 ; y<GRID_HEIGHT-1 ; y++) grid[GRID_WIDTH-1][y] = L'\u2551'; 
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

int main() {
  setlocale(LC_ALL, "en_US.UTF-8");  // Ensure UTF-8 locale
  
  init_gridbox();
  
  // Game loop :
  while(!good_to_exit) {
    redraw_all();
    //assess_snakehead();
    react_to_key();
    if(good_to_exit) break; 
    //advance_gamestate();
  }

  wipe_screen();
  return 0;
}
