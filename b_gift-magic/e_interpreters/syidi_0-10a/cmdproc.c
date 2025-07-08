#include <unistd.h>
#include "cmdproc.h"

void handle_cmd(unsigned char * cbuf){
  int ci = 0;
  
  printf("Starting command handling ...\n");
  printf("Command line buffer: ");
  fflush(stdout);
  
  while(cbuf[ci] != '\n') {
    write(STDOUT_FILENO , &cbuf[ci] , 1);
    ci++; 
  }
  write(STDOUT_FILENO , &cbuf[ci] , 1);
  
  printf("Finished command handling.\n");
}
