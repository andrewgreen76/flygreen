#include "modes.h"

#define KBDSIG_EOF NULL
#define STDIN_SIZE 2048

//////////////////////////////////////////////////////////////

void handle_REPL(){
 
  char user_input[STDIN_SIZE];

  while(1){
    printf("syidi < ");
    if ( fgets(user_input, STDIN_SIZE, stdin) == KBDSIG_EOF ) { printf("\n"); break; }
    printf("You wrote: %s" , user_input);
  }
}

//////////////////////////////////////////////////////////////

void handle_scriptexec(){
}
