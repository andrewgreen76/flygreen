#include <stdio.h>
#include "repl.h"
#include "screxec.h"

///////////////////////////////////////////////////////////////

int main(int argc , char * argv[] ){

  // Program entrance - validity check : 
  if(argc==1) handle_REPL();
  else if(argc==2) handle_script();
  else {
    printf("syidi: ERROR: Only up to two arguments are allowed.\n");
    return -1;
  }
  
  // EXIT. Return the status code to the inquiring parent process. 
  return 0;
}
