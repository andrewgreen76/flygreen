#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("\n");

  int i;
  int *arr = calloc(sizeof(int), 5);
  //
  for (i = 0; i < 5; i++) {
    printf("[%d]", arr[i]);
  }
  printf("\n");

  
  arr = realloc(arr, sizeof(int) * 10);
  //
  for (i = 0; i < 10; i++) {
    printf("[%d]", arr[i]);
  }
  printf("\n");
  //
  free(arr);

  printf("\n");
}
