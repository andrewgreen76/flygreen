#include "stdio.h"
#include "limits.h" // for ints
#include "float.h" // for doubles

int main()
{
  printf("\nINT_MIN is: %d\n", INT_MIN);
  printf("INT_MAX is: %d\n", INT_MAX);
  printf("size of int is: %ld\n\n", sizeof(int));

  printf("\nDBL_MIN is: %f\n", DBL_MIN);
  printf("DBL_MAX is: %f\n", DBL_MAX);
  printf("size of double is: %ld\n\n", sizeof(double));
  
  return 0;
}
