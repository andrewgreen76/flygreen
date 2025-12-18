#include <stdio.h>

/*
"... the actual address will vary depending on your system and whether address space layout randomization (ASLR) is enabled."
 */

typedef struct Crystal{
  int blah;
} Crystal;

void main(){
  struct Crystal crystal1;
  crystal1.blah = 0;
  printf("> %p\n" , (void*)main );
  printf("> %p\n" , (void*) &crystal1 );
}
