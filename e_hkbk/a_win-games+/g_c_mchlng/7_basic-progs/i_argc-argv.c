#include <stdio.h>

int main(int argc, char **argv)
{
  printf("\n");
  printf("\n");
  printf("Your argc is: %i\n", argc);

  for(int i=0; i<argc; i++)
    printf("Your argv[%i] is: %s\n", i, argv[i]);

  //printf("Your argv[0] is: %s\n", argv[0]);
  //if(argv[1]) printf("Your argv[1] is: %s\n", argv[1]);
  //strcpy();

  printf("\n");
  return 0;
}
