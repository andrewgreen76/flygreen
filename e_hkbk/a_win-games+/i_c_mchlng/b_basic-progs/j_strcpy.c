
/* USE STRLEN(), NOT LEN*SIZEOF(ARGV[X]) */

#include <stdio.h>
#include <string.h>

//#define bfsz 3
const int bfsz = 3;

int main(int argc, char **argv)
{
  char buff[bfsz];
  //
  printf("\n");

  printf("argv[1] : %s\n", argv[1]);
  printf("The size of argv[1] (really STRLEN()) is : %li\n", strlen(argv[1]));
  printf("The bfsz*sizeof(char) is : %li\n", bfsz*sizeof(char));

  if(strlen(argv[1]) == bfsz*sizeof(char))
  {
    printf("\nA match! \n");
    strcpy(buff, argv[1]);
  }

  printf("Your string is: %s \n", buff);
  printf("\n");
  //
  return 0;
}
