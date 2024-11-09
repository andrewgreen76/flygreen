#include <stdio.h>

int main(int argc , char ** argv){
  unsigned int ui = 4294967296; 
  
  printf("Decimal : %u", ui);  // 0
  printf("\n");
  printf("Hex : %x", ui);      // 0
  printf("\n");
}

/*
5_carry32.c: In function ‘main’:
5_carry32.c:4:21: warning: unsigned conversion from ‘long int’ to ‘unsigned int’ changes value from ‘4294967296’ to ‘0’ [-Woverflow]
    4 |   unsigned int ui = 4294967296;
      |                     ^~~~~~~~~~
*/
