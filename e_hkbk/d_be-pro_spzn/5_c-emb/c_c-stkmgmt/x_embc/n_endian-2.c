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
                        // &i = 0x 7ffc551658d0

  printf("&i : %p\n", &i );
  printf("(char *) &i : %p\n", (char *) &i );
  
  /*
  char * c = (char *) &i; 

  if(*c) printf("Little-endian\n");
  else printf("Big-endian\n");
  */

  int g = 0x00000001;   // g = 00 00 00 01
                        //              ^ 
                        // &g = 0x 7ffc551658d0
  //printf("&g : %p", &g );
  //char j = &g;
  //printf("Out : %s", (char *) &g );
  //(char) &g  // Take the var.address
  //int *h = &g;
  //printf("Out : %d", *h);

  printf("\n");
}
