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
  if(ENDEBUG) printf("Starting REPL ...\n");
  set_noncanon();

  // Line-by-line : 
  while(kc!=EOT) {
    printf("syidi < ");
    fflush(stdout);

    // Char-by-char : 
    kc = -1;  // If Enter pressed @ prev REPL , then reset.
    ci = 0; 
    while( !(kc=='\n' || kc==EOT) ){
      read(STDIN_FILENO , &kc , 1);
      cbuf[ci] = kc;
      write(STDOUT_FILENO , &kc , 1); // Makes char echo happen.
      ci++;
    } //EOL

    if(kc=='\n') handle_cmdl(cbuf);
    
  } //EOREPL

  restore_canon();  
  if(ENDEBUG) printf("\nFinished performing REPL.\n");
}
