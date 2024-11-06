#include "kheap.h"
#include "heap.h"
#include "config.h"

struct heap kheap;    // primitive inheritance
struct heap_table khptable;

void kheap_init(){
  khptable.entries = (hptbl_entry *) (HPTABLE_ADDR);
  khptable.max_entries = HEAP_SIZE / HPBLOCK_SIZE; 
}
