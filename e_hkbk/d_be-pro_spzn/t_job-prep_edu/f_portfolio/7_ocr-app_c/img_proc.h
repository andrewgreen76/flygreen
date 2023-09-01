#ifndef IMG_PROC_H
#define IMG_PROC_H
#include <stdio.h>
//#define NDEBUG
#include <assert.h>
#include "ProcList.h"
#include "BmpHeader.h"

// Function prototypes
void get_img_props(ProcList * , BmpHeader * );
void proc_img();

#endif
