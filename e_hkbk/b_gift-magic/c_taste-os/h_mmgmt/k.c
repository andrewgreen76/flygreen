#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int N = 0, i=0, sum=0;
  int * int_arr; 

  printf("Enter value of N [1-10]: ");
  scanf("%d", &N);
  int_arr = (int * )malloc( N*sizeof(int) );
  if(!int_arr) return 1;

  printf("Enter %d integer number(s)\n", N);  
  for(i=0 ; i<N ; i++){
    printf("Enter #%d: ", i+1);
    scanf("%d", int_arr+i );
    sum += int_arr[i];
  }
  printf("Sum: %d", sum);
  
  free(int_arr);
  return 0;
}
