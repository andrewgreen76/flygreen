#include <stdio.h>

#define KBD_EOF NULL

///////////////////////////////////////////////////////////////

void main(int argc , char * argv[] ){

  // Program entrance - validity check : 
  if(argc==1) handle_scriptexec();
  else if(argc==2) handle_REPL();
  else printf("ERROR: Only up to two arguments are allowed.\n"); 
  
  /*  
  char user_input[2048];

  while(1){
    printf("SYIDI < ");
    if ( fgets(user_input, 2048, stdin) == KBD_EOF ) { printf("\n"); break; }
    printf("You wrote: %s" , user_input);
  }
  */
  
  // EXIT. 
}
