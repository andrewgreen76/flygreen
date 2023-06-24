#include <stdio.h>

void asl(int *);

int main() {
  printf("\n");
  
  int val = 1; // 0000 0000 0000 0000, 0000 0000 0000 0001 
  asl(&val);
  asl(&val);
  asl(&val);
    
  printf("\n");
  return 0;
}

void asl(int * v_in){
  *v_in = *v_in << 1;    
  printf("Shift result: %i \n", *v_in);
  return;
}
