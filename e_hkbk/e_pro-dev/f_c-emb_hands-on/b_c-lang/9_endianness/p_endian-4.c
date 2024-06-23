#include <stdio.h>

int main(){
  printf("\n");

  unsigned int i = 0x01020304; // 00000001 00000010 00000011 00000100 | Little-ending : value populated in mem as : MSB<-LSB 
  char * b = (char *) &i;      // 0x ab..f ab.....e ab.....d ab.....c
                               //                               &i
                               // 
                               // Take the address of the entire int, cast it as an addr to its first byte. 
                               // This is called "type punning".
                               // 
                               // Load addr of 1st byte into a ptr. 

  //////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  unsigned int j = 0x00000001; // 00000000 00000000 00000000 00000001 
  char * c = (char *) &j;      // 0x ab..f ab.....e ab.....d ab.....c
  
  if(*c) printf("Little-endian\n");   // If reading from the LSB (that holds the 1)
  else printf("Big-endian\n");        // If reading from the MSB (that doesn't have the 1)

  printf("\n");
}
