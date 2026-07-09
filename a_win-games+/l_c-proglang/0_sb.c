#include <stdio.h>
#include <stdlib.h> // for rand()/srand() for randnumgen
#include <time.h>   // for randnumgen ops

#define RANDMAXLIM 2

int outcome_val = 0;

void main(){
  srand((unsigned int)time(NULL));
  int randint;
  
  do
  {
    randint = rand() % RANDMAXLIM;
    printf("randint is: %d\n", randint);
  }
  while(0);
  
  if(1) printf("This must have been quite a time you've paved.\n");
  //if(randint/RANDMAXLIM) printf("All your opponents are defeated.\n");
  if(1) printf("Did you win or lose?\n");
}
