#include <stdio.h>
#include <termios.h> // keyboard handling. 
#include <unistd.h>  // for sleeping in microsecs to give time.
#include <fcntl.h>   // for file/stream management. 
// #include <assert.h>  // spits out meaningless error messages. 

#define ENABLE_PRINTDBG 0
#define GRID_WIDTH 135
#define GRID_HEIGHT 35
#define REFLMARGTILE_CHAR '#'
#define PAD1TILE_CHAR 'H'
#define PAD2TILE_CHAR 'I'
#define BALL_CHAR 'O'
#define CLEAR_CHAR ' '
#define PADLEN 7
//
#define ASKED_TO_EXIT 1
#define NEWRALLY 2
#define PAD2_SERVES 4

/* BSS/data */
unsigned char gridmem[GRID_WIDTH][GRID_HEIGHT];
unsigned char game_flags = NEWRALLY;
int pad1_topref = GRID_HEIGHT/2 - PADLEN/2 , pad2_topref = GRID_HEIGHT/2 - PADLEN/2;
int ballloc_x = 0 , ballloc_y = 0,
  ballvel_x = 1 , ballvel_y = 0;
unsigned int pad1_score = 0 , pad2_score = 0;
unsigned int stdin_ch = 0;

/******************************************************/
/******************************************************/
/******************************************************/

void give_time2act(){
  usleep(50000);
}

/******************************************************/
/******************************************************/
/******************************************************/

void init_margins(){

  if(ENABLE_PRINTDBG) printf("Populating reflective margins ...\n");
  
  for(int x=0 ; x<GRID_WIDTH ; x++)
    gridmem[x][0] = REFLMARGTILE_CHAR;
  for(int x=0 ; x<GRID_WIDTH ; x++)
    gridmem[x][GRID_HEIGHT-1] = REFLMARGTILE_CHAR;

  if(ENABLE_PRINTDBG) printf("Reflective margins populated.\n");
}

/******************************************************/
/******************************************************/
/******************************************************/

void clear_fieldmem(){

  if(ENABLE_PRINTDBG) printf("Sanitizing the field ...\n");

  for(int y=1 ; y<GRID_HEIGHT-1 ; y++)
    for(int x=0 ; x<GRID_WIDTH ; x++)
      gridmem[x][y] = CLEAR_CHAR;

  if(ENABLE_PRINTDBG) printf("Field sanitized.\n");
}

/******************************************************/
/******************************************************/
/******************************************************/

void print_gridmem(){

  if(ENABLE_PRINTDBG) printf("Printing the entire grid ...\n");
  
  for(int y=0 ; y<GRID_HEIGHT ; y++){
    for(int x=0 ; x<GRID_WIDTH ; x++){
      printf("%c" , gridmem[x][y]);
    }
    printf("\n");
  }
  printf("Pad 1: %d \t Pad 2: %d\n" , pad1_score , pad2_score);
      
  if(ENABLE_PRINTDBG) printf("Entire grid printed.\n");
}

/******************************************************/
/******************************************************/
/******************************************************/

void populate_pads2gridmem(){
  
  for(int offset=0 ; offset<PADLEN ; offset++) {
    gridmem[0][pad1_topref+offset] = PAD1TILE_CHAR;
    gridmem[GRID_WIDTH-1][pad2_topref+offset] = PAD2TILE_CHAR;
  }
}

/******************************************************/
/******************************************************/
/******************************************************/

void clear_screen(){
  printf("\033[H\033[J");
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
  stdin_ch = getchar();

  // Enable canonical mode : 
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);

  if(stdin_ch != EOF) return 1;    // ch=/=-1 => Was pressed.
  
  return 0;
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void react2key(){
  
  if ( get_stdin_char() ) {
    if(stdin_ch=='w') pad1_topref--;
    if(stdin_ch=='s') pad1_topref++;
    if(stdin_ch==27) {
      
      get_stdin_char();
      // An esc.seq ? 
      if(stdin_ch==91){
	
	get_stdin_char();  // Expect up/down arrows. 
        if(stdin_ch==65)
	  pad2_topref--;
        if(stdin_ch==66)
	  pad2_topref++;
      }
      else game_flags |= ASKED_TO_EXIT;
    }

    if(pad1_topref<1) pad1_topref=1;
    if(pad1_topref>= GRID_HEIGHT-PADLEN) pad1_topref= GRID_HEIGHT-PADLEN-1;
    if(pad2_topref<1) pad2_topref=1;
    if(pad2_topref>= GRID_HEIGHT-PADLEN) pad2_topref= GRID_HEIGHT-PADLEN-1;
  }

}

/******************************************************/
/******************************************************/
/******************************************************/

void place_ball2gridmem(){
  
  if( !(game_flags & PAD2_SERVES) ) {
    ballloc_x = 1;
    ballloc_y = pad1_topref + PADLEN/2;
  }
  else {
    ballloc_x = GRID_WIDTH-2;
    ballloc_y = pad2_topref + PADLEN/2;
    game_flags &= (PAD2_SERVES ^ 0xff);
  }

}

/******************************************************/
/******************************************************/
/******************************************************/

void populate_ball(){
  gridmem[ballloc_x][ballloc_y] = BALL_CHAR;  
}

/******************************************************/
/******************************************************/
/******************************************************/

void check_collw_reflmarg(){
  if(ballloc_y<=1 || ballloc_y>=GRID_HEIGHT-2) ballvel_y *= -1;
}

/******************************************************/
/******************************************************/
/******************************************************/

void drive_ballcoords(){
  ballloc_x += ballvel_x;
  ballloc_y += ballvel_y;
  /*
    Preliminary collision check w/ top and bottom margins.
    With the hack that simulates angular reflection the ball can skip specific boundaries.
    We also do not want to write to memory address out of the grid's bounds. 
  */
}

/******************************************************/
/******************************************************/
/******************************************************/

void check_collw_pad(){

  // Collision with pad 1: 
  if(ballloc_x<=1 && (ballloc_y-pad1_topref)==0 ) {
    ballvel_x=1;
    ballvel_y=-2;
  }
  else if(ballloc_x<=1 && (ballloc_y-pad1_topref)==1 ) {
    ballvel_x=2;
    ballvel_y=-2;
  }
  else if(ballloc_x<=1 && (ballloc_y-pad1_topref)==2 ) {
    ballvel_x=2;
    ballvel_y=-1;
  }
  else if(ballloc_x<=1 && (ballloc_y-pad1_topref)==3 ) {
    ballvel_x=3;
    ballvel_y=0;
  }
  else if(ballloc_x<=1 && (ballloc_y-pad1_topref)==4 ) {
    ballvel_x=2;
    ballvel_y=1;
  }
  else if(ballloc_x<=1 && (ballloc_y-pad1_topref)==5 ) {
    ballvel_x=2;
    ballvel_y=2;
  }
  else if(ballloc_x<=1 && (ballloc_y-pad1_topref)==6 ) {
    ballvel_x=1;
    ballvel_y=2;
  }

  ////////////// Collision with pad 2: 
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==0 ) {
    ballvel_x=-1;
    ballvel_y=-2;
  }
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==1 ) {
    ballvel_x=-2;
    ballvel_y=-2;
  }
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==2 ) {
    ballvel_x=-2;
    ballvel_y=-1;
  }
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==3 ) {
    ballvel_x=-3;
    ballvel_y=0;
  }
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==4 ) {
    ballvel_x=-2;
    ballvel_y=1;
  }
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==5 ) {
    ballvel_x=-2;
    ballvel_y=2;
  }
  else if(ballloc_x>=GRID_WIDTH-2 && (ballloc_y-pad2_topref)==6 ) {
    ballvel_x=-1;
    ballvel_y=2;
  }
}

/******************************************************/
/******************************************************/
/******************************************************/

unsigned char is_pad_missed(){

  return (ballloc_x<=0 || ballloc_x >= GRID_WIDTH-1);  
}

/******************************************************/
/******************************************************/
/******************************************************/

void handle_newrally(){

  if(ballloc_x <= 0){
    game_flags |= PAD2_SERVES;
    pad2_score++;
  }
  if(ballloc_x >= GRID_WIDTH-1){
    pad1_score++;
  }
  
  game_flags |= NEWRALLY;  
}

/******************************************************/
/******************************************************/
/******************************************************/

int main(){

  // Setup / fixed parts : 
  init_margins();

  // Game logic loop : 
  while( !(game_flags & ASKED_TO_EXIT) ) {
    clear_screen();  // Helps with proper grid-to-screen refresh. 
    clear_fieldmem();
    populate_pads2gridmem();       // Pads do not need resetting.
    if( game_flags & NEWRALLY ) {
      place_ball2gridmem();        // The ball does need resetting.
      game_flags &= (NEWRALLY ^ 0xff);       
    }

    // Ball event handling :
    check_collw_pad();  // Starts with a shot. 
    drive_ballcoords();       // Motion takes place.
    check_collw_reflmarg(); // Check valid.mem before writing to out of bounds. 
    
    if( !is_pad_missed() ) {
      populate_ball(); 
    }
    else handle_newrally();
    
    print_gridmem();    
    give_time2act(); 
    react2key();
    //else return 0;
  }
  clear_screen(); 
  return 0;
}
