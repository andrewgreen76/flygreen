#include <stdio.h>

int main() {
  // Output the BEL character to produce a beep sound
  for(int t=0; t<1000000; t++) printf("\a");

  return 0;
}
