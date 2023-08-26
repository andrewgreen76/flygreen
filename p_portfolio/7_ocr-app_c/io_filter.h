#ifndef IO_FILTER_H
#define IO_FILTER_H
#include <stdio.h>
#include <stdlib.h> // for free()
#include <stdbool.h> // using true and false for a more readable code
#include <string.h>
#include "ProcList.h"

// Function prototypes
bool is_imgfile(char * );
bool fhere(char * );     // FILE EXISTS check 
bool strfilled(char * ); // NON-EMPTY STRING check
void get_valid_name();
void get_bounded_vals( );

#endif
