#include <stdio.h>

int main() {
  printf("sizeof(int) : %li", sizeof(int));
  
  int value = 10; // 0000 0000 0000 0000, 0000 0000 0000 1010 
  int invalidShift = value << 32;  // Shift by 32 bits
  
  printf("Invalid shift result: %d \n", invalidShift);
  
  return 0;
}

