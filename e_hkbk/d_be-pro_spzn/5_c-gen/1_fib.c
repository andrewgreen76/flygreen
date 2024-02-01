#include <stdio.h>

void fib(int a, int b) {
  //if (a!=0) printf(", "); 

  if(a<=100) {
    printf("%i ", a);  
    fib(b, a+b);
  }
}

int main(int argc, char * argv[]) {
  printf("\n");
  printf("You know what has three commas in it, Richard?\n");

  fib(0, 1);

  printf("\n");
  printf("\n");

  return 0 ;
}
