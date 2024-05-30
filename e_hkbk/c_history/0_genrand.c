#include <stdio.h>
#include <stdint.h>

void main(){
  int var;
  
  uintptr_t addr = (uintptr_t) &var;
  printf("Address (ptr repr) : %p\n" , (void *) &addr);
  
  uint64_t addr48 = (uint64_t) addr;
  printf("Address (uint64_t) : %lx\n" , (uint64_t) &addr48);
  
  uint64_t sdl = addr & 0x0000ffffffff;
  printf("Address (uint64_t) shifted left : %lx\n" , (uint64_t) &sdl);
  uint64_t sdr = sdl >> 4;
  printf("Address (uint64_t) shifted right : %ld\n" , (uint64_t) &sdr >> 4);
}
