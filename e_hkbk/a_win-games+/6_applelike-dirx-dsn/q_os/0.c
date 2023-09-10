#include <stdio.h>

int main(int argc, char * argv[])
{
  printf("\n");

  printf("Hello, world\n");

  unsigned int i = 1;
  char *c = (char *) &i;
  printf("Out: %d\n", *c);
  
  printf("\n");
  return 0;
}
