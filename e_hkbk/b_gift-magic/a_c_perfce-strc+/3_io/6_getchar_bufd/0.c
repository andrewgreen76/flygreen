#include <stdio.h>

void main(){
  printf("Start\n");
  char c = NULL;
  
  while(c != EOF){
    getchar();
    putchar(c);
  }
  
  printf("End\n");
}
