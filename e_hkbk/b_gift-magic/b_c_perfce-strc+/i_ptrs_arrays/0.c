
#include <stdio.h>

typedef unsigned char    byte; 

void main(){
  printf("\n");
  
  unsigned short one = 1;
  byte * a = (byte *) (&one);

  if(*a) printf("Lil\n");
  else printf("Big\n");
  
  printf("\n");
}
