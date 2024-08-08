/*
realloc() : 
. It will NOT automatically assign 0 to the elements in the EXPANSION to the array. 
. WARNING : If there's not enough memory for the expanded array at the current location , the array will be moved. 
  This will create problems with all the pointers that you would tie to the array. 
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("\n");
  int i;
  // ==================== CALLOC ====================
  int *arr = calloc(sizeof(int), 5);
  //
  for (i = 0; i < 5; i++) {
    printf("[%d]", arr[i]);
  }
  printf("\n");
  // ==================== REALLOC ====================
  /*
    Reallocating beyond initialized elements. 
   
  arr = realloc(arr, sizeof(int) * 10);
  //
  for (i = 0; i < 10; i++) {
    printf("[%d]", arr[i]);
  }
  printf("\n");
  */
  // ==================== REALLOC ====================
  /*
    Promised shrinking. 
   */
  arr = realloc(arr, sizeof(int) * 3);
  //
  for (i = 0; i < 3; i++) {
    printf("[%d]", arr[i]);
  }
  printf("\n");
  // ==================== THE END ====================  
  free(arr);
  printf("\n");
}
