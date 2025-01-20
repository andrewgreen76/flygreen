#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  
  // srand - inits a random number generator ;
  // current time as the seed - to ascertain "more random" output : 
  srand(time(NULL));

  int random_number = rand(); // Generates a number between 0 and RAND_MAX

  // To generate a number within a specific range, use modulo. 
  int min = 1, max = 100;
  int random_in_range = ( rand() % (max - min + 1) ) + min;

  printf("Random number: %d\n", random_number);
  printf("Random number in range (%d - %d): %d\n", min, max, random_in_range);

  return 0;
}
