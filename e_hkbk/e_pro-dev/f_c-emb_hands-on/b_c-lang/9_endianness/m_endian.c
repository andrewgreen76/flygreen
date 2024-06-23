#include <stdio.h>

int main(){
  unsigned int i = 1;    printf("\ni is : %X", i);
  printf("\nsizeof(unsigned int) : %li", sizeof(unsigned int));
  printf("\nsizeof(i) : %li\n", sizeof(i));

  char * c = (char*) &i;    printf("Defining a pointer to the multi-byte buffer of i (a char can store a byte)\n");

  printf("Dereferencing the first memory address\n");
  if(*c) printf("Little-endian\n");
  else printf("Big-endian\n");

  printf("\n");
  return 0;
}
