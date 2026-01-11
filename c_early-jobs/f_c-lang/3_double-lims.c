#include <stdio.h>

int main(int argc, char * argv[]){
  double d = 10.12345123451234512345;  
  printf("%.19f\n", d);
  d = 101.2345123451234512345;    
  printf("%.19f\n", d);
  d = 10123451234512345.12345;    
  printf("%.19f\n", d);
}
