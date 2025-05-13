#include <stdio.h>

int main(){
  char buf[5000];

  fgets(buf , 5000 , stdin);
  printf("%s" , buf);

  return 0;
}
