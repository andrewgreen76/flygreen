#include <stdio.h>
#include <stdint.h>

int main(){
  unsigned int a = -1;
  printf("unsigned int : %u\n" , a);
  uint8_t b = -1;
  printf("uint8_t : %u\n" , b);
  uint16_t c = -1;
  printf("uint16_t : %u\n" , c);
  uint32_t d = -1;
  printf("uint32_t : %u\n" , d);

  printf("a : %x\n" , a);
  printf("b : %x\n" , b);
  printf("c : %x\n" , c);
  printf("d : %x\n" , d);
}
