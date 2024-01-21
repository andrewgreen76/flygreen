#include "stdio.h"

//#define s 5
const int s = 5; // Keeping it a const is good practice ; we don't want this var to be altered. 

int main()
{
  //int a[s] = {1,2,3,4,5};
  /*
    ain.c:8:3: error: variable-sized object may not be initialized
    8 |   int a[s] = {1,2,3,4,5};
      |   ^~~
   */
  int a[] = {1,2,3,4,5};
  int m = s/2;
  printf("\n");

  //swapping:
  //
  for(int i=0; i<m; i++)
  {
    int t = s-1-i;
    a[i] ^= a[t] ^= a[i] ^= a[t];
  }
  
  //printing:
  //
  for(int i=0; i<s; i++)
    printf("%i\n", a[i]);
  
  printf("\n");  
  return 0;
}

/*
- An array is a pointer 

  int arr[6]={11,12,13,14,15,16};

  : arr is a pointer that stores the address of the first element in the array

- An array is contiguous blocks of memory that store a value
 */
