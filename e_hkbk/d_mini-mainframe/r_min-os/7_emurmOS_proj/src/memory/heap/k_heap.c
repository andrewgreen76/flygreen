#include "k_heap.h"
#include "heap.h"
#include "config.h"

struct heap k_heap;    // primitive inheritance
struct heap_table k_hptable;

void k_heap_init(){
  k_hptable.max_entries = HEAP_SIZE / HPBLOCK_SIZE; 
  k_hptable.entries = (void *) 0x0;
}
