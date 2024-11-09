#include <stdio.h>

int main(int argc , char ** argv){
  unsigned int ui = -1; 
  
  printf("Decimal : %u", ui); // 4294967295   // %d might cause undef.behavior. 
  printf("\n");
  printf("Hex : %x", ui);     // 0xffffffff
  printf("\n");
}
