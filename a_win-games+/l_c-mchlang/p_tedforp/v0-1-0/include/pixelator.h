#ifndef PXLATE_H
#define PXLATE_H

#define FG_BLACK  30
#define FG_RED    31
#define FG_GREEN  32
#define FG_BROWN  33
#define FG_BLUE   34
#define FG_PURPLE 35
#define FG_TEAL   36
#define FG_WHITE  37

#define BG_BLACK  40
#define BG_RED    41
#define BG_GREEN  42
#define BG_BROWN  43
#define BG_BLUE   44
#define BG_PURPLE 45
#define BG_TEAL   46
#define BG_WHITE  47

void clrterm();
void emp_chsett();
void renew_chsett();
void test_color();

#endif 
