#include <stdio.h>

int main(){
  printf("\n");

  unsigned int i = 0x04030201;
  char * b = (char *) &i;
  
  for(int c=0; c < 4 ; c++) printf("@ %p : %d\n", b+c, *(b+c) );

  //if(*b) printf("Little-endian\n");   
  //else printf("Big-endian\n");        

  printf("\n");
}
