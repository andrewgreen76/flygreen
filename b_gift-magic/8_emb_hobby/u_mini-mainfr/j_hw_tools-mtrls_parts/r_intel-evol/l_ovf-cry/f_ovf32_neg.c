#include <stdio.h>

int main(int argc , char ** argv){
  int si = -2147483649; // 2147483647 -> 2147483648 
                       // -2147483648 -> -2147483649
  
  printf("Decimal : %d", si); // 2147483647
  printf("\n");
  printf("Hex : %x", si);     // 0x7fffffff
  printf("\n");
}

/*
0.c: In function ‘main’:
0.c:4:12: warning: overflow in conversion from ‘long int’ to ‘int’ changes value from ‘-2147483649’ to ‘2147483647’ [-Woverflow]
    4 |   int si = -2147483649; // 2147483647 -> 2147483648
      |            ^
*/
