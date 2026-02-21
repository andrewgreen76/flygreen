#include <stdlib.h>

int main(void) {

  int *a = (int *) malloc(sizeof(int)); // rets ptr to the int. 
  *a = 1; // deref nicknamed int slot, put 1 in there. 
}
