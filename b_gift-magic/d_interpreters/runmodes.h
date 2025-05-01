#ifndef RUNMODES_H
#define RUNMODES_H

#include <stdio.h>
#include "debug.h"

//#define KBDSIG_EOF NULL
#define EOT 4
#define STDIN_SIZE 2048

void handle_REPL();
void handle_scriptexec();

#endif
