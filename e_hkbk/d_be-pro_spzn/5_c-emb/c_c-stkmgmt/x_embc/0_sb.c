#include <stdio.h>

int main() {
  printf("\n");
  
  int a = 1, b = 2, c;

  printf("a = %d\n", a);
  printf("b = %d\n", b);
  printf("\n");
  /*
  c = a;
  a = b;
  b = c;
  */

  /*
    a = 0001
    b = 0010

    a = 0011
    b = 0010

    a = 0011
    b = 0001

    a = 0010
    b = 0001
   */
  
  a ^= b ^= a ^= b;
  
  printf("a = %d\n", a);
  printf("b = %d\n", b);
  
  printf("\n");
}
