/*
  sizeof(int_ptr) = 8 bytes 
  sizeof(int) = 4 bytes 

  Statically allocating memory for an int charges FOUR bytes on the stack (as though your machine is 32-bit). 
  Dynamically allocating memory for an int charges EIGHT bytes on the heap (as though your machine is 64-bit).
*/

#include <stdio.h>
#include <stdlib.h>

int main(){
  printf("\n");

  int w;
  int x[10];
  int *y = (int * )malloc( sizeof(int) );
  int *z = (int * )malloc( 10*sizeof(int) );
  
  printf("sizeof(int) = %ld\n", sizeof(w) );
  printf("sizeof(int_arr) = %ld\n", sizeof(x) );
  printf("\n");
  printf("sizeof(int_ptr y) = %ld\n", sizeof(y) );
  printf("sizeof(deref'd y) = %ld\n", sizeof(*y) );
  printf("\n");
  printf("sizeof(intarr_ptr z) = %ld\n", sizeof(z) );
  printf("sizeof(deref'd z ptr to the first of ten ints) = %ld\n", sizeof(*z) );
  
  printf("\n");
}
