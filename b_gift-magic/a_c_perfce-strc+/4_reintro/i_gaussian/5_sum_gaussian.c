
#include <stdio.h>
#define MIN 1
#define MAX 100

int get_gsum(){
  if( (MAX-MIN)%2 ){              // even number in the set 
    int times = (MAX-MIN+1)/2;    // 1..100 ; 2..101
  }
  else{                           // odd number in the set
  }
  
  return 0;
}

void main(){
  printf("\n");
  
  printf("Gaussian sum : %d\n" , get_gsum() );
  
  printf("\n");
}
