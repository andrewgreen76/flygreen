#include <stdio.h>

int main(){
  printf("\n");

  /*
    Little-endian : starting with the LSB
    Big-endian : starting with the MSB 
   */

  unsigned int i = 0x01020304;   // Ensure : MSB is not a sign bit, LSB holds 0000-0001 : 
                        // 0x   00 00 00 01
                        //      0000 0000 0000 0000    0000 0000 0000 0001
                        // &i = 0x    00 00 7f fc 55 16 58 d0

  /*
   size of ptr = 8 Bytes
       0x 00007ffc551658d0
   size of int = 4 Bytes
       0x 01020304 
       @
       0x 00007ffc551658dx
       0x 00007ffc551658dy
       0x 00007ffc551658dz
       0x 00007ffc551658d0
  */
  
  printf("&i : %p\n", &i );    // 0x7ffc551658d0
  char * w = (char *) &i
  
  printf("(char *) &i : %p\n",  w);
  printf("");

  printf("(char *) &i : %p\n", 1+ (char *) &i );

  printf("(char *) &i : %p\n", 2+ (char *) &i );

  printf("(char *) &i : %p\n", 3+ (char *) &i );

  /*
  char * c = (char *) &i;

  printf("*c : %d\n", *c );  
  printf("c : %p\n", c );  
  */
  
  //printf("Out is : %li", sizeof(&i) );
  
  /*
  if(*c) printf("Little-endian\n");
  else printf("Big-endian\n");
  */

  //int g = 0x01020304;   // g = 00 00 00 01
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
