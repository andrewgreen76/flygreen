#ifndef REPL_H
#define REPL_H

#include <stdio.h>
#include "debug.h"

#define EOT 4
#define STDIN_SIZE 2048

void set_noncanon();
void restore_canon();
void handle_cmd();
void handle_REPL();
void handle_scriptexec();

#endif
