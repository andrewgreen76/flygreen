/*
  Even though the heap chunk w/ ints is "released", the ints are still there and the mem.addr is still known. 
  Nevertheless, the chunk is <MARKED> AS REUSABLE and the ints can be overwritten. 
*/

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
