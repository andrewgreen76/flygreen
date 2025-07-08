#ifndef CMDPROC_H
#define CMDPROC_H

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include "debug.h"

bool handle_cmdl(unsigned char * cbuf);
bool chk_exit(unsigned char * cbuf);

#endif
