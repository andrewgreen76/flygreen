#include "stdio.h"

int main()
{
  int list[5] = {1,2,3,4,5};
  int h = sizeof(list);

  printf("\n\n");
  
  printf("%i", h);

  //printf("\n\n");

  //printf("Hello, world");
  
  return 0;
}

/*
- An array is a pointer 

  int arr[6]={11,12,13,14,15,16};

  : arr is a pointer that stores the address of the first element in the array

- An array is contiguous blocks of memory that store a value
 */
