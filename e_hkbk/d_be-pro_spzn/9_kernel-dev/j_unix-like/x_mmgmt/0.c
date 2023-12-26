#include <stdio.h>

char memory[20000];

int main(void) {
  printf("Using (void*) memory: %p\n", (void*) memory);
  printf("Using &memory: %p\n", (void*) &memory);

  return 0;
}
