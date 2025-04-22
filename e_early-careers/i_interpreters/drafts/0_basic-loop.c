#include <stdio.h>

///////////////////////////////////////////////////////////////
typedef unsigned char byte;
// typedef char* string;


///////////////////////////////////////////////////////////////
void main(){
  // string uprompt[1000];
  char uprompt[1000];
  
  while(1){
    printf("?: ");
    scanf("%s" , uprompt);
    printf("You wrote: %s\n" , uprompt);
  }
}
