#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include "runmodes.h"

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

void handle_REPL(){
 
  unsigned char istrbuf[STDIN_SIZE];
  unsigned short istrbuf_i = 0;
  unsigned char ch;
  
  set_noncanon();

  if(ENDEBUG) printf("Started performing REPL ...\n");
  
  while(ch!=EOT) {
    ch = 0;  // Obligatory read-char reset - to allow for the next REPL line prompt upon hitting Enter. 
    printf("syidi < ");
    fflush(stdout);

    while( !(ch=='\n' || ch==EOT) ){
      read(STDIN_FILENO , &ch , 1);
      write(STDOUT_FILENO , &ch , 1); // Makes char echo happen.
    }
  }

  restore_canon();
  
  if(ENDEBUG) printf("Finished performing REPL.\n");
}

//////////////////////////////////////////////////////////////

void handle_scriptexec(){
}
