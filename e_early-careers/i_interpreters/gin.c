#include <stdio.h>
#include "gintypes.h"

///////////////////////////////////////////////////////////////

void main(){
  string uprompt;
  
  while(1){
    printf("gin : ");
    if ( scanf("%s" , uprompt) == -1) { printf("\n"); break; }
    printf("You wrote: %s\n" , uprompt);
  }
}
