#include <stdio.h>

void main(){
  char arr[] = {'0', '1'};
  printf("Size of array: %ld\n", sizeof(arr) );

  printf("Elem: %c\n", arr[0] );
  printf("Elem: %c\n", arr[1] );
  printf("Elem: %c\n", arr[2] );
  printf("Elem: %hu\n", arr[3] );
  printf("Elem: %hu\n", arr[4] );
  printf("Elem: %hu\n", arr[5] );
}
