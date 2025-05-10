#ifndef CMDPROC_H
#define CMDPROC_H

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include "debug.h"

//#define ERRCMD_MALFORM printf("syidi > ERROR: command line not correctly formatted.\n");

bool handle_cmdl(unsigned char * cbuf);
bool chk_exit(unsigned char * cbuf);
void test_echocl(unsigned char * cbuf);
void test_splitcl(unsigned char * cbuf);
//void handle_script();

#endif
