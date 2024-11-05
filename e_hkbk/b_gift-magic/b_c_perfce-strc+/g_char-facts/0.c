
#include <stdio.h>

void main(){
  char baby = 128;
  
  printf("Size of char : %lu\n" , sizeof(char) );
  printf("Size of int : %lu\n\n" , sizeof(int) );
  
  printf("Size of * : %lu\n\n" , sizeof(void *) );

  printf("Baby is %d years old.\n" , baby);
}
