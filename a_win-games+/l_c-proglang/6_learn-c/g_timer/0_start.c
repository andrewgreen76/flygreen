#include <stdio.h>
#include <stdint.h>
#include <time.h>

int main(){
  uint8_t stopwatch = 0;

  while(1) printf("%t\n" , time(NULL) );
  
  return 0;
}
