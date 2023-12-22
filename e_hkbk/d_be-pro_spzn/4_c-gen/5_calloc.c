#include <stdio.h>
//#include <sys/mman.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  printf("\n");

  int *arr = calloc(sizeof(int), 10);
  
  int i;
  for (i = 0; i < 10; i++) {
    printf("[%d]", arr[i]);
  }
  printf("\n");

  free(arr);

  printf("\n");
}
