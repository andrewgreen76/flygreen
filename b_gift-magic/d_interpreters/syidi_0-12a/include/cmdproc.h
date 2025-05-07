#ifndef CMDPROC_H
#define CMDPROC_H

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include "debug.h"

void handle_cmdl(unsigned char * cbuf);
void test_echocl(unsigned char * cbuf);
void test_splitcl(unsigned char * cbuf);
//void handle_script();

#endif
