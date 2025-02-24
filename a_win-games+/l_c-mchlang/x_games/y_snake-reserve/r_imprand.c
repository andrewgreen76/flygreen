
// Compile and link with the <math.h> library or the utilities will fail to produce an executable.
// $ gcc 4_imprand.c -lm 

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>


int main() {

  // ================================ INGREDIENTS : =================================
  srand(time(NULL));
  int randum;
  int lsdigit;
  const int truncs_allowed = 7;  // To cut large numbers ? 
  int abs_truncr;    // Num of least sig digits to truncate = abs( truncs_allowed - lsdigit(0-9) )

  // =============================== PROGRAM LOGIC : ================================
  while(1) {
    randum = rand();        // xxxxxx
    lsdigit = randum % 10;  // _____x
    abs_truncr = abs(truncs_allowed - lsdigit);  // s
    randum = randum / (int) pow( (double)10 , (double)abs_truncr );
    printf("Random number: %d\n", randum);
  }
  
  return 0;
}



// ###################################################################################
// ###################################################################################
// ###################################################################################

/* =================================== THOUGHTS : ====================================

   . This program is OK, though with the way it produces "random" numbers it seems 
       to have a bias towards results with two or more digits. 

   . rand() generation has a heavy bias towards 8+ -digit values.
   => We can only truncate up to 7 least sig digits. 
   . On a few occasions it does produce a 6-7 -digit number. (x)xxx,xxx / 10,000,000 = 0. 
   => There is a chance - a deceptively good one - for the random number to turn out 
        to be 0, but that is because one launch of the program leads to innumerable 
        generation iterations, raising the likelihood of occurrence of 0. 

   . I should implement a way for the program to exit gracefully without having 
       the user to rely on Ctrl+C every time. This would mean integrating an unwieldy 
       piece of code which involves `termios` and is expected to do only one thing - 
       - allowing the program to continue and not exit until a key is pressed. 

*/
