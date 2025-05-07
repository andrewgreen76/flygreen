#include "cmdproc.h"

///////////////////////////////////////////////////////////

void handle_cmdl(unsigned char * cbuf){

  if(ENDEBUG) printf("Starting command handling ...\n");

  if(ENDEBUG){
    test_echocl(cbuf);
    //test_striplf(cbuf);
    //test_splitcl(cbuf);
  }

  
  //cmdsrh_statcd = system("./bin/throw"); 
  /*
  // Receive the "cmd" input and look for the bin.exec file : 
  ci = 0;
  while( cbuf[ci]!=' ' && cbuf[ci]!='\n' ){
    //
  }
  */
  
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
  /*
  // Scan-n'-print : 
  for( int ci = 0; cbuf[ci] ; ci++ ) 
    write(STDOUT_FILENO , &cbuf[ci] , 1);
  */
}
