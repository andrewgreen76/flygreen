#include "io_filter.h"
#include <stdio.h>
#include <stdlib.h> // for free()
//#include <string.h>
///////////////////////////////


void get_valid_name(ProcList * l)
{
  int bad_img_name = 1;
  char * in_str;
  size_t size = 0;
  
  do {
    printf("Name of target image file: ");
    
    if (getline(&in_str, &size, stdin) != -1) {
      // 
      bad_img_name = 0;
    } else {
        printf("You may be out of available memory.\n");
    }
    free(in_str);
    
  } while (bad_img_name);

  return;
}
//////////////////////////////////////////////////////////////////
void get_bounded_vals(ProcList * l)
{
  printf("Collecting bounded values ...\n");
  return;
}
