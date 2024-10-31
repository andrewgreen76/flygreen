
// Compile and link with the <math.h> library or the utilities will fail to produce an executable.
// $ gcc 4_imprand.c -lm 

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

int main() {
  
  srand(time(NULL));
  int randum;
  int lsdigit;
  const int truncs_allowed = 7;
  int abs_truncr;    // abs(truncs_allowed - lsdigit)

  while(1) {
    randum = rand();
    lsdigit = randum % 10;
    abs_truncr = abs(truncs_allowed - lsdigit);
    
    randum = randum / (int) pow( (double)10 , (double)abs_truncr );
    printf("Random number: %d\n", randum);
  }

  return 0;
}
