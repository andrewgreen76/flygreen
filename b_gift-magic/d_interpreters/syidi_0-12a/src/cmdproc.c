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

void test_echocl(unsigned char * cbuf){
  int ci = 0;
  
  // Command echo test : 
  printf("Command line buffer: ");
  fflush(stdout);

  // Scan-n'-print : 
  while(cbuf[ci] != '\0') {
    write(STDOUT_FILENO , &cbuf[ci] , 1);
    ci++; 
  }
  //write(STDOUT_FILENO , &cbuf[ci] , 1);
}
