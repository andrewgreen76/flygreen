
#include <stdio.h>

int main(void){
  printf("\n");
  
  void * addr_of_main = (void*) main;
  int a = 1;
  int * b = &a;
  printf("Addresses of functions : \n");
  printf("addr_of_main : %p\n" , addr_of_main);
  printf("\n");
  
  printf("Data addresses and the addresses of those addresses : \n");
  printf("addr of addr_of_main : %p\n" , & addr_of_main);
  printf("addr of addr_of_a : %p\n" , &b);
  printf("addr_of_a : %p\n" , b);
  
  printf("\n");
  return 0;
}
