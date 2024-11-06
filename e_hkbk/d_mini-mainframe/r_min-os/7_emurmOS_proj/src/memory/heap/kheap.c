#include "kheap.h"
#include "heap.h"
#include "config.h"

struct heap kheap;    // primitive inheritance
struct heap_table kheap_table;

void kheap_init(){
  kheap_table.entries = (hptable_entry *) (HPTABLE_ADDR);
  kheap_table.max_entries = HEAP_SIZE / HPBLOCK_SIZE; 
}
