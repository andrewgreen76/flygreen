
#include <stdio.h>

int main(void){
  printf("\n");
  
  void * addr_of_main = (void*) main;
  int a = 1;
  int * b = &a;
  printf("Relative addresses of code (functions) : \n");
  printf("&  main : \t %p\n" , addr_of_main);
  printf("\n");
  
  printf("Relative addresses of data (pointers , etc.) : \n");
  printf("&  a : \t\t %p\n" , b);
  printf("&& main : \t %p\n" , & addr_of_main);
  printf("&& a : \t\t %p\n" , &b);
  
  printf("\n");
  return 0;
}
