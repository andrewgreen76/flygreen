#include <stdio.h>
#include <stdlib.h>

int main(void) {
    
  // integer variables
  int N = 0;
  int sum = 0;
  int i;
  
  // integer pointer variables
  int *iptr, *tmp;
  
  // take user input
  printf("Enter value of N [1-10]: ");
  scanf("%d", &N);
  
  // allocate memory
  iptr = (int *) malloc(N * sizeof(int));
  
  // check if memory allocated
  if (iptr == NULL) {
    printf("Unable to allocate memory space. Program terminated.\n");
    return -1;
  }
  
  // take integers
  printf("Enter %d integer number(s)\n", N);
  for (i = 0, tmp = iptr; i < N; i++, tmp++) {
    printf("Enter #%d: ", (i+1));
    scanf("%d", tmp);
    
    // compute the sum
    sum += *tmp;
  }
  
  // display result
  printf("Sum: %d\n", sum);
  
  // free memory location
  free(iptr);

  return 0;
}
