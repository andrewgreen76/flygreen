#include "io_filter.h"
#include <stdio.h>
#include <stdlib.h> // for free()
//#include <string.h>
///////////////////////////////

bool chk_exist(char * s)
{
  return true;
}

void get_valid_name(ProcList * l)
{
  bool good_img_name = false;
  char * filename;
  size_t size = 0;
  
  do {
    printf("Name of target image file: ");
    
    if (getline(&filename, &size, stdin) != -1) { 
      good_img_name = chk_exist(filename); // further checks;
    } else {
        printf("You may be out of available memory.\n");
    }
    free(filename);
    
  } while (!good_img_name);

  return;
}
//////////////////////////////////////////////////////////////////
void get_bounded_vals(ProcList * l)
{
  printf("Collecting bounded values ...\n");
  return;
}
