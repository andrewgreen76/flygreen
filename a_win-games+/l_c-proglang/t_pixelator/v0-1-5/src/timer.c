#include "timer.h"

void delay(unsigned long int ticks){
  ticks *= 2000000000;  // Default : 2B iterations per tick. 
  for( ; ticks ; ticks-- );
}
