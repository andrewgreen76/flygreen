#include <stdio.h>

int main(){

  for( int c=32 ; c<127 ; c++ ){
    printf("%d - %c\n" , c , c );
  }
  
  return 0;
}
