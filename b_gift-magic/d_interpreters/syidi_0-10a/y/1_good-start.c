#include <stdio.h>
#include "ytypes.h"

///////////////////////////////////////////////////////////////

void main(){
  string uprompt;
  
  while(1){
    printf("yokai : ");
    if ( scanf("%s" , uprompt) == -1) { printf("\n"); break; }
    printf("You wrote: %s\n" , uprompt);
  }
}
