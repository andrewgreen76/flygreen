#include <stdio.h>
#include <stdlib.h>

int main() {
  int iasize; // unknown
  int * iarr; // will hold addr of array

  printf("\nPlease enter the size for the array of integers you want to create: "); // << 
  scanf("%i", &iasize); // >> \n

  iarr = (int *)malloc(iasize * sizeof(int));

  if(iarr != NULL) {
    void* iaddr = (void*)iarr; // void* can hold anything, ESPECIALLY MEMORY ADDRESSES. 
    printf("Available memory found and allocated at: %p", iaddr); //
    
    free(iarr);
    printf("\nAllocated memory released\n\n");
  }
  else {
    printf("Memory unavailable");
  }

  // Do NOT free here - potential invalid free. 
  
  return 0;
}
