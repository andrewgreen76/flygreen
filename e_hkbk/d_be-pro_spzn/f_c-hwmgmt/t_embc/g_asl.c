#include <stdio.h>

int main() {
  printf("sizeof(int) : %li", sizeof(int));
  
  int value = 10; // 0000 0000 0000 0000, 0000 0000 0000 0000, 0000 0000 0000 0000, 0000 0000 0000 1010 
    
  // Invalid shift by a value greater than or equal to the width of int
  int invalidShift = value << 32;  // Shift by 32 bits
  
  printf("Invalid shift result: %d \n", invalidShift);
  
  return 0;
}

/*
g_asl.c: In function ‘main’:
g_asl.c:9:28: warning: left shift count >= width of type [-Wshift-count-overflow]
    9 |   int invalidShift = value << 32;  // Shift by 32 bits
      |                            ^~
sizeof(int) : 4Invalid shift result: 10 
*/
