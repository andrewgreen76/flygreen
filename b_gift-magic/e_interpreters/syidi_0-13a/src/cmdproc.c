#include "cmdproc.h"

///////////////////////////////////////////////////////////
// Command recognition : (a) meta-cmd (not a sep.proc) , (b) bin.exec (a sep.proc) , (c) fail. 
///////////////////////////////////////////////////////////

void handle_cmdl(unsigned char * cbuf){

  if(ENDEBUG) printf("Starting command handling ...\n");
  
  if(ENDEBUG) printf("Finished command handling.\n");
}

///////////////////////////////////////////////////////////

void test_splitcl(unsigned char * cbuf){
  
}

///////////////////////////////////////////////////////////
// Command echo test : 
///////////////////////////////////////////////////////////

void test_echocl(unsigned char * cbuf){
  printf("Command line buffer: ");
  fflush(stdout);
  printf("%s" , cbuf);
}
