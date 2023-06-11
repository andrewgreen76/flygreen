#include "stdio.h"

int main()
{
  int a = 5;
  int * p = &a;

  printf("\na is: %i\n\n", *p);
  
  return 0; 
}
