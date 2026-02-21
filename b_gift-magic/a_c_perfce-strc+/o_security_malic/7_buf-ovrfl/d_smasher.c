#include <stdio.h>

int main( int argc , char *argv[] )
{
  char input[10];
  scanf("%s" , input);

  /* asdfghjklsdfghjkl;
     *** stack smashing detected ***: terminated
     Aborted (core dumped)
  */
  
  return 0;
}
