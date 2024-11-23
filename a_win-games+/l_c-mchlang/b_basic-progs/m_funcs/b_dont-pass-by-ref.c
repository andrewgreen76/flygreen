// Don't pass by reference in C. This is something that C++ can do. 

#include <stdio.h>

void asl(int &);

int main() {
  printf("\n");
  printf("sizeof(int) : %li\n", sizeof(int));
  
  int v = 1; // 0000 0000 0000 0000, 0000 0000 0000 0001 

  asl(v);
  asl(v);
  asl(v);
    
  printf("\n");
  return 0;
}

void asl(int & v){
  v = v << 1;    
  printf("Shift result: %d \n", v);
  return;
}
