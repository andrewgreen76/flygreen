#include <stdio.h>

int main(){
  int addr_int = 1234;
  //char addr_char = 0xff;
  
  printf("\n%x\n\n", addr_int >> 8);
  printf("\n%x\n\n", addr_int );
  //printf("\n%i\n\n", (int)0x7fffffff );
  //printf("\n%i\n\n", (int)0x7fffffff + 1 );
}
