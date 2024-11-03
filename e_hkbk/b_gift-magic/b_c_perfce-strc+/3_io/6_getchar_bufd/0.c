
#include <stdio.h>


void main(){
  printf("Start\n");
  char c = '?';

  // get[..] - state of lingering
  // while() - state of parsing 
  while(c != EOF){
    printf("(tg)");
    c = getchar();    // Skipped because ch =/= '\n' ??
    printf("(tp)");
    putchar(c);
    printf("(ti)");
  }
  
  printf("End\n");
}


/* 
   Perhaps to best understand the language and the <stdio.h> functions
     it is best to write the functions (or the language/compiler) all
     by yourself. 
*/
