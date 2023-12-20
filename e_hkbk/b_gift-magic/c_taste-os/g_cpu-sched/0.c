#include <stdio.h>

void print_all(int a,int b,int c){
  printf("\n");
  printf("a: %d\n", a);
  printf("b: %d\n", b);
  printf("c: %d\n", c);
}

int main(){
  printf("\n");

  int a = 0, b = 0, c = 0;
  //printf("\n");

  printf("a++: %d\n", a++);
  printf("++b: %d\n", ++b);
  printf("c: %d\n", c);

  print_all(a,b,c);
  
  printf("\n");
}
