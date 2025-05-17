#include <stdio.h>
#include <stdint.h>

void f1();
void f2();
void f3();

////////////////////////////////////////////
int main(){

  void (*tests[])() = { *f1 ,
			*f2 ,
			*f3 };
  uint8_t numtests = sizeof(tests) / sizeof(tests[0]);
  
  for( uint8_t fi=0 ; fi<numtests ; fi++ ){
    tests[fi]() ;
  }
  
  return 0;
}

////////////////////////////////////////////
void f1(){
  printf("What ");
}

void f2(){
  printf("is ");
}

void f3(){
  printf("up ?\n");
}
