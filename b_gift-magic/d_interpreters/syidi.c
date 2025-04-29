#include <stdio.h>
#include "stypes.h"

///////////////////////////////////////////////////////////////

void main(){
  string uprompt;
  
  while(1){
    printf("SYIDI < ");
    if ( scanf("%s" , uprompt) == -1) { printf("\n"); break; }
    printf("You wrote: %s\n" , uprompt);
  }
}
