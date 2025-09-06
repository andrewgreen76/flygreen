#include <stdio.h>
#include <math.h>

void main(){
  int p=1;

  printf("%d\n" , (int) pow(5,2) );

  for(int t=0 ; t<2 ; t++){
    p*=5;
  }
  printf("%d\n" , p );

}
