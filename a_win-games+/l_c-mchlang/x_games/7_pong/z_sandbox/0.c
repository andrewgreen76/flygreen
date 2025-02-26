#include <stdio.h>
#include <stdbool.h>

void main(){
  printf("Size of UNSIGNED CHAR : %ld\n" , sizeof(unsigned char) );
  printf("Size of BOOL : %ld\n" , sizeof(bool) );
  printf("Size of SHORT : %ld\n" , sizeof(short) );
  printf("Size of INT : %ld\n" , sizeof(int) );
  printf("Size of *ptr : %ld\n" , sizeof(int * ) );
}
