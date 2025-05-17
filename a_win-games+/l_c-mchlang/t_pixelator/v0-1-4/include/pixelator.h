#ifndef PIXELATOR_H
#define PIXELATOR_H

//#define RLS_BLD 0
#define DBG_BLD 1

#include <stdio.h>
#include <stdint.h>
#include <wchar.h>
#include <locale.h>
#include <unistd.h>
#include <termios.h>
#include "ansi.h"
#include "timer.h"
#include "res.h"

struct termios term_can, term_nocan; 

void setup();
void cleanup();
void kill_canonical();
void reset_canonical();
void do_tests();

#endif 
