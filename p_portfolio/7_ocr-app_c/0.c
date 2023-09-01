#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  printf("\n");

  int num = 42;
  char str[20];
  sprintf(str, "%d", num);
  printf("%s", str);
  
  printf("\n");  
  return 0;
}
