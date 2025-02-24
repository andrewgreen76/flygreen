#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

/********************************************************************/
/********************************************************************/
/********************************************************************/

int main() {

  printf("\033[H\033[J");
  //printf("\033[H");  // go to origin of screen without clearing. 
  //printf("\033[J");  // does not do anything, but seems to call for clearing when \033[H is used. 
  sleep(1);
  
  return 0;
}
