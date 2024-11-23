#include <stdio.h>

int main(){
  unsigned char b = 0b10110010;
  unsigned char r = 0b00000000;

  r = (b * 0x0202020202ULL & 0x010884422010ULL) % 1023; // unsigned long long 

  printf("Original: %d (binary: %08b)\n" , b, b);
  printf("Reversed: %d (binary: %08b)\n" , r, r);
}
