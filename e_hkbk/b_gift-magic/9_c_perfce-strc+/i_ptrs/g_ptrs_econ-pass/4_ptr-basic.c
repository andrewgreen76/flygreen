#include "stdio.h"

int main()
{
  /*A pointer is a variable that holds the address of another variable.

  What does it look like?*/

  int a = 5;
  int * p = &a;

  printf("\na is: %i\n\n", *p);
  
  return 0; 
}
