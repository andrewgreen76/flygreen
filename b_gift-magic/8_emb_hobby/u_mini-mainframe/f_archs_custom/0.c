#include <stdio.h>

void main(){
  char arr[] = {'0', '1'};
  printf("Size of array: %ld\n", sizeof(arr) );

  for (int i=0 ; i<10 ; i++) {
    printf("Elem: %c\n", arr[i] );
  }
}
