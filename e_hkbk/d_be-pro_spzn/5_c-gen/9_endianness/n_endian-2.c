#include <stdio.h>

int main(){
  printf("\n");

  /* Which way is the main memory populated ? : 

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
       0x 00007ffc551658df - 0x 01
       0x 00007ffc551658de - 0x 02
       0x 00007ffc551658dd - 0x 03
       0x 00007ffc551658dc - 0x 04
  */
  
  printf("&i : %p\n", &i );    // 0x7ffc551658d0
  char * w = (char *) &i;      // as a ptr to a byte of memory, not as a ptr to a char. 
  
  printf("(char *) &i : %p\n",  w);
  printf("%x\n", *w);

  w++;
  printf("(char *) &i : %p\n",  w);
  printf("%x\n", *w);

  w++;
  printf("(char *) &i : %p\n",  w);
  printf("%x\n", *w);

  w++;
  printf("(char *) &i : %p\n",  w);
  printf("%x\n", *w);

  printf("\n");
}
