#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include "repl.h"

struct termios termst0; 

////////////////////////////////////////////////////////

void set_noncanon(){
  struct termios termst1; 

  tcgetattr(STDIN_FILENO , &termst0);      // get_termst0() and preserve_termst0();
  termst1 = termst0;                       // init_termst1();
  termst1.c_lflag &= ~(ICANON | ECHO);        // mod_termst1();
  tcsetattr(STDIN_FILENO, TCSANOW, &termst1); // load_termst1();
}

void restore_canon(){
  tcsetattr(STDIN_FILENO, TCSANOW, &termst0);
}

//////////////////////////////////////////////////////////////
// REPL loop : w/ real-time char processing (mid-line). 
//////////////////////////////////////////////////////////////

void handle_REPL(){
 
  unsigned char kc;                 // latest char caught , NOT a ptr. 
  unsigned char cbuf[STDIN_SIZE];  // stdin skimmer buffer 
  unsigned short ci;              // stdin skimmer buffer index
  bool sigexit = 0;
  if(ENDEBUG) printf("Starting REPL ...\n");
  set_noncanon();

  // Line-by-line : 
  while( !sigexit ) {
    printf("syidi < ");
    fflush(stdout);

    // Char-by-char : 
    kc = -1;  // If Enter pressed @ prev REPL , then clear the line feed.
    ci = 0; 
    while( !(kc=='\n' || kc==EOT) ){
      read(STDIN_FILENO , &kc , 1);
      cbuf[ci] = kc; 
      write(STDOUT_FILENO , &kc , 1); // Makes char echo happen.
      ci++;
      
      if(ci==STDIN_SIZE-1){
	printf("ERROR: Command line limit reached.\n");
	goto handle_errcllim;
      }
    } //EOL

    // EOCL case handling : 
    if(kc=='\n') {
      cbuf[ci] = '\0';  // Prep for any str.ops. 
      if( handle_cmdl(cbuf) ) sigexit = 1;  // On exit. 
    }
    if(kc==EOT) sigexit = 1;
  
  handle_errcllim:
  }
  //EOT => EOREPL

  ////////////////// EPILOGUE code : //////////////////
  restore_canon();  
  if(ENDEBUG) printf("\nFinished performing REPL.\n");
}
