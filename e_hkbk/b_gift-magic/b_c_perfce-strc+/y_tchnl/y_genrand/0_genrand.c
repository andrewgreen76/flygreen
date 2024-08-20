#include <stdio.h>
#include <stdint.h>

void main(){

  // Get 4-byte void pointer : 
  int var = 1;
  printf("Address (ptr repr) : %p\n" , (void *) &var);

  // Now render as 8-byte pointer : 
  uintptr_t addr_8byte = (uintptr_t) &var;
  printf("Address (uintptr repr) : %lx\n" , (uintptr_t) addr_8byte);

  // Now render as actionable integer : 
  uint64_t addr_masked = ((uint64_t) addr_8byte) & 0x0;
  printf("Address (uint64_t) shifted right : %ld\n" , (uint64_t) addr_masked);

  /*       
  uint64_t sdl = addr & 0x0; //0X00000000FFFFFFFF;
  printf("Address (uint64_t) shifted left : %lx\n" , (uint64_t) &sdl);

  /*       
  uint64_t sdr = sdl >> 4;
  printf("Address (uint64_t) shifted right : %ld\n" , (uint64_t) &sdr >> 4);
  */
}
