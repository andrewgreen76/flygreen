
#include <stdio.h>

void main(){
  char baby = 128;  
  printf("\n");
  
  printf("Size of char : %lu\n" , sizeof(char) );
  printf("Size of short : %lu\n" , sizeof(short) );
  printf("Size of int : %lu\n" , sizeof(int) );
  printf("Size of double : %lu\n" , sizeof(double) );
  printf("Size of long : %lu\n" , sizeof(long) );
  printf("Size of long long : %lu\n" , sizeof(long long) );
  printf("Size of size_t : %lu\n" , sizeof(size_t) );
  printf("\n");
  
  printf("Size of * : %lu\n\n" , sizeof(void *) );

  printf("Baby is %d years old.\n" , baby);
  printf("\n");
}
