/*
calloc(sizeof(int), 10) 
. performs the multiplication all on its own 
. can also be written as calloc(10 , sizeof(int)) - doesn't matter 
. prevents integer overflow 
. assigns the default value of 0 automatically to every requested variable or array byte 
. see "man calloc"
 */

#include <stdio.h>
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
