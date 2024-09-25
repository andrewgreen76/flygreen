#include <stdio.h>

int main(int argc , char ** argv){
  int si = 2147483648; // 2147483647 -> 2147483648 
                       // -2147483648 -> -2147483649
  
  printf("Decimal : %d", si); // -2147483648
  printf("\n");
  printf("Hex : %x", si);     // 0x80000000
  printf("\n");
}
