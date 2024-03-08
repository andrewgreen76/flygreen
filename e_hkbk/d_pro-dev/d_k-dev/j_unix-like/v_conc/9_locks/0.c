#include <stdio.h>

int main(){
  printf("\n");

  int a = -1;
  printf("Sign : %d\n" , (a>>31) && 1 );
  
  printf("\n");
}
