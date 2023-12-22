#include <stdio.h>

int main(void){
  printf("\n");

  char *srcPointer = "hi\0";

  /*
  printf("%c", *srcPointer );
  srcPointer++;
  printf("%c", *srcPointer );
  srcPointer++;
  */
  
  /*
  while(srcPointer != NULL) {
    printf("%c", *srcPointer );
    srcPointer++;
  }
  */
  printf("%s\n", srcPointer);

  printf("\n");
}
