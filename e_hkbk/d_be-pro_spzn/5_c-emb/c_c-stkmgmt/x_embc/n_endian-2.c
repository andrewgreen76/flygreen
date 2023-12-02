#include <stdio.h>

int main(){
  printf("\n");

  /*
    Little-endian : starting with the LSB
    Big-endian : starting with the MSB 
   */

  unsigned int i = 1;   // Ensure : MSB is not a sign bit, LSB holds 0000-0001 : 
                        // 0x   00 00 00 01
                        //      0000 0000 0000 0000    0000 0000 0000 0001

  printf("&i : %p\n", &i );
  printf("(char *) &i : %p\n", (char *) &i ); 
  /*
  char * c = (char *) &i; 

  if(*c) printf("Little-endian\n");
  else printf("Big-endian\n");
  */
  printf("\n");
}
