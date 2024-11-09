#include <stdio.h>

int main(int argc , char ** argv){
  unsigned int ui = -1; 
  
  printf("Decimal : %u", ui); // 4294967295   // %d might cause undef.behavior. 
  printf("\n");
  printf("Hex : %x", ui);     // 0xffffffff
  printf("\n");
}

/*
"GCC does not throw errors or warnings for the line `unsigned int ui = -1;` 
   because C allows implicit conversion from a negative integer to an unsigned 
   type, resulting in the value being wrapped around to the maximum representable 
   value of the unsigned type without triggering a diagnostic message."
*/
