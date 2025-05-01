#include "runmodes.h"

//////////////////////////////////////////////////////////////

void handle_REPL(){
 
  char user_input[STDIN_SIZE];

  while(1){
    printf("syidi < ");
    if ( fgets(user_input, STDIN_SIZE, stdin) == EOT ) { printf("\n"); break; }
    printf("You wrote: %s" , user_input);
  }
}

//////////////////////////////////////////////////////////////

void handle_scriptexec(){
}
