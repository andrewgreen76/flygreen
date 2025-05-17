#ifndef PIXELATOR_H
#define PIXELATOR_H

//#define RLS_BLD 0
#define DBG_BLD 1

#define UPHALF_BLACK  30
#define UPHALF_RED    31
#define UPHALF_GREEN  32
#define UPHALF_BROWN  33
#define UPHALF_BLUE   34
#define UPHALF_PURPLE 35
#define UPHALF_TEAL   36
#define UPHALF_WHITE  37

#define LOHALF_BLACK  40
#define LOHALF_RED    41
#define LOHALF_GREEN  42
#define LOHALF_BROWN  43
#define LOHALF_BLUE   44
#define LOHALF_PURPLE 45
#define LOHALF_TEAL   46
#define LOHALF_WHITE  47

#include <stdio.h>
#include <stdint.h>
#include <wchar.h>
#include <locale.h>
#include <unistd.h>
#include <termios.h>
#include "ansi.h"
#include "timer.h"

struct termios term_can, term_nocan; 

void setup();
void cleanup();
void kill_canonical();
void reset_canonical();
void do_tests();

#endif 
