
/////////////////////////////////////

#include <stdio.h>

#define SIZE 3
int arr[SIZE] , t=0 ;

/////////////////////////////////////

void print_arr() {  
  for( t=0 ; t<SIZE ; t++ ) {
    arr[t]=t;
    printf("%d : %d\n" , t , arr[t]);
  }
}

/////////////////////////////////////

void main(){
  
  print_arr();
  
  int d = 1;
  arr[d] = d++;
  
  print_arr();  
}
