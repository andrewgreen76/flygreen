#include <stdio.h>
#include <stdlib.h>

int main() {
  int casize; // unknown
  char * carr; // will hold addr of array

  printf("\nPlease enter the size for the array of CHARACTERS you want to create: "); // << 
  scanf("%i", &casize); // >> \n

  carr = (char *)malloc(casize * sizeof(char));

  if(carr != NULL) {
    void* caddr = (void*)carr; // void* can hold anything, ESPECIALLY MEMORY ADDRESSES. 
    printf("Available memory found and allocated at: %p", caddr); // \n

    free(carr);
    printf("Allocated memory released\n\n");
  }
  else {
    printf("Memory unavailable");
  }

  // Do NOT free here - potential invalid free. 
  
  return 0;
}
