#include <stdio.h>
#include "types.h"

///////////////////////////////////////////////////////////////

void main(){
  string uprompt;
  
  while(1){
    printf("syidi < ");
    if ( scanf("%s" , uprompt) == -1) { printf("\n"); break; }
    printf("You wrote: %s\n" , uprompt);
  }
}
