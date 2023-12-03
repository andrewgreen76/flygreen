#include <stdio.h>
#include <stdlib.h>

int main(){
  printf("\n");
  
  int * arr = (int *)malloc(3*sizeof(int));
  printf("@ : %p \n", arr);
  free(arr);
  printf("@ : %p \n", arr);
  
  printf("\n");
}
