#include <stdio.h>
#include <unistd.h>

int main() {

  int t=0;
  
  while(1){
    printf("Tick: %d\n" , t);
    sleep(1);
    t++;
  }
  
  return 0;
}
