#include <stdio.h>
#include <stdbool.h>

struct A {
  bool a;
  double b;
};

struct B {
  double a;
  int b;
};

void main(){
  printf("Size of bool: %ld\n" , sizeof(bool) );
  printf("Size of int: %ld\n" , sizeof(int) );
  printf("Size of double: %ld\n" , sizeof(double) );

  printf("Size of struct A: %ld\n" , sizeof(struct A) );
  printf("Size of struct B: %ld\n" , sizeof(struct B) );  
}
