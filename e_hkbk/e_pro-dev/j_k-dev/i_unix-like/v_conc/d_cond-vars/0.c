#include <stdio.h>

int main(){
  printf("\n");
  
  int i = 1;
  char * p = (char *) &i;
  printf("%d\n" , *p);

  printf("\n");
}
