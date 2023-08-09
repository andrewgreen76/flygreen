#include "stdio.h"

int main(int argc, char * argv[])
{
  printf("\nCheers! Making your way in a world today.\n\n");

  char * mys = "Mary had";
  printf("\nThe string is: %s\n", mys);

  // Spying the characters : 
  printf("\nMem addr of mys: %p\n", (void*)mys);
  printf("\nChar 0: %c\n", (*mys));
  printf("\nChar 1: %c\n", *(mys+1));
  printf("\nChar 2: %c\n", *(mys+2));
  printf("\nChar 3: %c\n", *(mys+3));
  printf("\nChar 4: %c\n", *(mys+4));
  //printf("\nChar 5: %c\n", *(mys+5));
  *(mys+1) = 'o';

  /*  
  printf("\nMem addr of mys: %p\n", (void*)mys);
  printf("\nChar 0: %c\n", (*mys));
  printf("\nChar 1: %c\n", *(mys+1));
  printf("\nChar 2: %c\n", *(mys+2));
  printf("\nChar 3: %c\n", *(mys+3));
  printf("\nChar 4: %c\n", *(mys+4));
  */  
  printf("\n");
  return 0;
}
