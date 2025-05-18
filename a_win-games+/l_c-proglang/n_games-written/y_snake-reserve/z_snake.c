#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

int ch = 0;
int good_to_exit = 0;

/******************************************************************/
/******************************************************************/
/******************************************************************/

void redisplay_all(){
  printf("Re-displaying all ...\n");
  printf("Re-displayed all.\n");
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void assess_snakehead(){
  printf("Testing for head collision ...\n");
  printf("Tested for head collision.\n");
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

int kbhit(void) {
  struct termios oldt, newt;
  int oldf;

  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO); 
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
  fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

  ch = getchar();

  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);

  if(ch != EOF) {    // Was pressed.
    return 1;
  }
  
  return 0;
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void react_to_key(){

  printf("Awaiting key input ...\n");
  sleep(1);  // Take 1s to register key input.
  
  if (kbhit()) {
    //printf("A KEYPRESS!!!\n");
    if (ch==27) good_to_exit = 1;
  }
  
  printf("Handled key input.\n");
  
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

void advance_gamestate(){
  printf("Advancing game state ...\n");
  printf("Advanced game state.\n");
}

/******************************************************************/
/******************************************************************/
/******************************************************************/

int main() {

  // Game loop :
  while(!good_to_exit) {
    redisplay_all();
    assess_snakehead();
    react_to_key();
    if(good_to_exit) break;
    advance_gamestate();
  }
  
  return 0;
}
