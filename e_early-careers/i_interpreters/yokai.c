#include <stdio.h>
#include "ytypes.h"

///////////////////////////////////////////////////////////////

void main(){
  // string uprompt[1000];
  string uprompt;
  
  while(1){
    printf("yokai : ");
    if ( scanf("%s" , uprompt) == -1) break;
    printf("You wrote: %s\n" , uprompt);
  }
}
