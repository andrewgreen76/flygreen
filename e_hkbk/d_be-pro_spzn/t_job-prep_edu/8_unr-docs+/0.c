#include <stdio.h>

void fib(int a, int b) {
  if (a!=0) printf(", "); 
  printf("%i", a);
    
  if(b<=100) fib(b, a+b);
  else printf("\n");
}

int main(int argc, char * argv[]) {
  printf("\n");
  printf("Do you know what has three commas in it?\n");

  fib(0, 1);

  printf("\n");

  return 0 ;
}
