#include "cmdproc.h"

///////////////////////////////////////////////////////////
// Command recognition : (a) meta-cmd (not a sep.proc) , (b) bin.exec (a sep.proc) , (c) fail.
//  - Handling = recognizing (w/ workarounds) + taking action. 
///////////////////////////////////////////////////////////

bool handle_cmdl(unsigned char * cbuf){

  if(ENDEBUG) printf("Starting command line handling ...\n");

  if( chk_exit(cbuf) ) return true;
  else printf("ERROR: command not recognized.\n");
  
  if(ENDEBUG) printf("Finished command line handling.\n");
  return false;
}

///////////////////////////////////////////////////////////

bool chk_exit(unsigned char * cbuf){

  uint16_t chead = 0;

  while( cbuf[chead]==' '
	 || cbuf[chead]=='\t'
	 || cbuf[chead]=='\n' )
    { chead++; };
  
  if( !(cbuf[chead++]=='e'
	&& cbuf[chead++]=='x'
	&& cbuf[chead++]=='i'
	&& cbuf[chead++]=='t') )
    { return false; }

  while( cbuf[chead]==' '
	 || cbuf[chead]=='\t'
	 || cbuf[chead]=='\n' )
    { chead++; };

  if( !cbuf[chead] ) return true;  // for valid 'exit' format.
  // Else, 
  printf("ERROR: command line not correctly formatted.\n");
  return false;
}
