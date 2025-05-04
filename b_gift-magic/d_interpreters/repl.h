#ifndef REPL_H
#define REPL_H

#include <stdio.h>
#include "debug.h"

#define EOT 4
#define STDIN_SIZE 2048

void set_noncanon();
void restore_canon();
void handle_cmd(unsigned char * );
void handle_REPL();

#endif
