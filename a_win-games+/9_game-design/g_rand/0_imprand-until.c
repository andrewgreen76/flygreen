
/* Compile and link with the <math.h> library with the prompt line below;
   otherwise the utilities will fail to produce an executable: 

   $ gcc 5_imprand-until.c -lm 

   Then run "./a.out". 
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

int kbhit();

/////////////////////////////////////////////////////////////////////////////////////////////
// ================================ FUNCTION DEFINITIONS : ==================================
/////////////////////////////////////////////////////////////////////////////////////////////

// ======================================= MAIN : =====================================
int main()
{
  srand(time(NULL));
  int randnum;
  int lsdigit;
  const int truncs_allowed = 7;  
  int abs_truncr;    // Num of least sig digits to truncate = abs( truncs_allowed - lsdigit(0-9) )

  while(!kbhit()) {
    randnum = rand();
    lsdigit = randnum % 10;
    abs_truncr = abs(truncs_allowed - lsdigit);
    randnum = randnum / (int) pow( (double)10 , (double)abs_truncr );
    printf("Random number: %d\n", randnum);
  }
  
  return 0;
}

// ================================ REACT TO KEYPRESS : ===============================
int kbhit() {
  struct termios oldt, newt;
  int oldf;

  tcgetattr(0, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(0, TCSANOW, &newt);
  oldf = fcntl(0, F_GETFL, 0);
  fcntl(0, F_SETFL, oldf | O_NONBLOCK);

  int ch = getchar();

  tcsetattr(0, TCSANOW, &oldt);
  fcntl(0, F_SETFL, oldf);

  if(ch != EOF) {
    ungetc(ch, stdin);
    return 1;
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

*/
