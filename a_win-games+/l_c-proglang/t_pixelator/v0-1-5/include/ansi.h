#ifndef ANSI_H
#define ANSI_H

#define SHOW_TEST_MSGS 0

#define HI_BLK  30
#define HI_RED  31
#define HI_GRN  32
#define HI_GLD  33
#define HI_BLU  34
#define HI_PUR  35
#define HI_TEA  36
#define HI_WHT  37

#define LO_BLK  40
#define LO_RED  41
#define LO_GRN  42
#define LO_GLD  43
#define LO_BLU  44
#define LO_PUR  45
#define LO_TEA  46
#define LO_WHT  47

#include <stdio.h>
#include <stdint.h>
#include "debug.h"
#include "res.h"
#include "timer.h"

//void test_vertsweep();
void test_horsweep();
void test_resfade();
void test_resgrain();
void test_palette();
void clear_term();
void reset_colors();

#endif
