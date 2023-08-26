#ifndef IO_FILTER_H
#define IO_FILTER_H
#include <stdbool.h> // using true and false for a more readable code 
#include "ProcList.h"

// Function prototypes
bool chk_exist(char * );
void get_valid_name(ProcList * );
void get_bounded_vals(ProcList * );

#endif
