#include <unistd.h>
#include "cmdproc.h"

void handle_cmdl(unsigned char * cbuf){
  int ci = 0;
  
  printf("Starting command handling ...\n");
  
  printf("Command line buffer: ");
  fflush(stdout);  
  while(cbuf[ci] != '\n') {
    write(STDOUT_FILENO , &cbuf[ci] , 1);
    ci++; 
  }
  write(STDOUT_FILENO , &cbuf[ci] , 1);

  ci = 0;
  while( cbuf[ci]!=' ' && cbuf[ci]!='\n' ){
    
  }
  
  printf("Finished command handling.\n");
}
