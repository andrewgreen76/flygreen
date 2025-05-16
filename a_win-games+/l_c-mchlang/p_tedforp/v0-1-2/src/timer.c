#include "timer.h"

void delay(unsigned int ticks){
  ticks *= 2000000000;
  for( ; ticks ; ticks-- );
}
