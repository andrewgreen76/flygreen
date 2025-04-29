#include <stdio.h>
#include <limits.h>
#include "stypes.h"

#define KBD_EOF -1

///////////////////////////////////////////////////////////////

void main(){
  string uprompt;
  
  while(1){
    printf("SYIDI < ");
    if ( scanf("%s" , uprompt) == KBD_EOF ) { printf("\n"); break; }
    printf("You wrote: %s\n" , uprompt);
  }
}
