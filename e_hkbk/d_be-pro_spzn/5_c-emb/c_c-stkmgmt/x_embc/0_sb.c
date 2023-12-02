#include <stdio.h>

int main() {
  printf("\n");
  
  int a[] = {1,2};

  if(a == &a[0]) printf("Bazinga!\n");
  else printf("... Not bazinga. (:-( \n");
  
  printf("\n");
}
