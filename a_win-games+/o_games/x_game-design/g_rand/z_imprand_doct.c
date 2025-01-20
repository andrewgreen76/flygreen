
// Compile and link with the <math.h> library or the utilities will fail to produce an executable.
// $ gcc 4_imprand.c -lm 

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define DELAY 10000



int main() {

  // ================================ INGREDIENTS : =================================
  srand(time(NULL));
  int randum;
  int lsdigit;
  const int truncs_allowed = 7;    // rand() tends to generate 8+ -digit numbers
                                   // => we can only truncate up to 7 least sig digits
  
  int abs_truncr;    // abs( truncs_allowed - lsdigit(0-9) )

  // =============================== PROGRAM LOGIC : ================================
  while(1) {
    randum = rand();
    printf("A really large random number: %d\n", randum);
    
    lsdigit = randum % 10;
    printf("Least significant digit: %d\n", lsdigit);
    
    abs_truncr = abs(truncs_allowed - lsdigit);
    printf("Digits to truncate: %d\n", abs_truncr);
    
    randum = randum / (int) pow( (double)10 , (double)abs_truncr );
    printf("Final random number: %d\n\n", randum);

    for(int c=0; c<DELAY; c++);
  }
  
  return 0;
}



// ###################################################################################
// ###################################################################################
// ###################################################################################

/* =================================== THOUGHTS : ====================================

   . This program is OK, though with the way it produces "random" numbers it seems 
       to have a bias towards results with two or more digits. 

   . I should implement a way for the program to exit gracefully without having 
       the user to rely on Ctrl+C every time. This would mean integrating an unwieldy 
       piece of code which involves `termios` and is expected to do only one thing - 
       - allowing the program to continue and not exit until a key is pressed. 

*/
