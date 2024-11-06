#include "k_heap.h"
#include "heap.h"
#include "config.h"

struct heap k_heap;    // primitive inheritance
struct heap_table k_table;

void k_heap_init(){
  unsigned int max_entries = HEAP_SIZE / HPBLOCK_SIZE;

  k_table.entries = (void *) 0x0;
  k_table.total = max_entries; 
}
