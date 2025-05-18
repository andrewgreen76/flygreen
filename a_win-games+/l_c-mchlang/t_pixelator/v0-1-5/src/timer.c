#include "timer.h"

void delay(unsigned long int ticks){
  ticks *= 2000000000;
  for( ; ticks ; ticks-- );
}
