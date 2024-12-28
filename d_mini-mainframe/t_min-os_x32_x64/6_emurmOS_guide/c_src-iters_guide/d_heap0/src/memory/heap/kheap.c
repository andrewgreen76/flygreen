#include "kheap.h"
#include "heap.h"
#include "config.h"
#include "kernel.h"

struct heap kheap;    // primitive inheritance
struct heap_table kheap_table;  // kheap already has *table 

void kheap_init(){
  kheap_table.entries = (heap_entry *) (HPTABLE_ADDR);
  kheap_table.max_entries = HEAP_SIZE / HPBLOCK_SIZE;

  void * heap_end = (void*)(HEAP_ADDR + HEAP_SIZE);
  int response = heap_create( &kheap , (void*) (HEAP_ADDR) , heap_end , &kheap_table);

  if(response<0){
    printstr("Creating heap FAILED\n");
  }
  
}
