#include "memory.h"


             // loc     // val        // memsize
void* memset(void* ptr , int c , size_t size){
  
  char * c_ptr = (char *) ptr;
  
  for(int i=0 ; i<size ; i++)
    c_ptr[i] = (char) c;     // populate
  
  return ptr;
}
