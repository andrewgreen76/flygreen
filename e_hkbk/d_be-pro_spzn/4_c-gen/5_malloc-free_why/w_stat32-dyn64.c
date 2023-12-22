#include <stdio.h>
#include <stdlib.h>

int main(){
  printf("\n");

  int w;
  int x[10];
  int *y = (int * )malloc( sizeof(int) );
  int *z = (int * )malloc( 10*sizeof(int) );
  
  printf("%ld\n", sizeof(w) );
  printf("%ld\n", sizeof(x) );
  printf("%ld\n", sizeof(y) );
  printf("%ld\n", sizeof(z) );
  
  printf("\n");
}
