#include <stdio.h>

void main(){
  char * memglass = (char *) (0xA0000000);
  if (* memglass) printf("@ A0000000 : %c\n" , * memglass);
}
