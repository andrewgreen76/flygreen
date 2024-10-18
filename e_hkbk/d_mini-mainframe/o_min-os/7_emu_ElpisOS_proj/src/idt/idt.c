#include "idt.h"
#include "config.h"
#include "memory/memory.h"

struct idt_desc idt_descriptors[NUM_INTERRUPTS];
struct idtr_desc idtr_descriptor;


// Helps set interrupts and their addresses within IDT : 
void idt_set(int interrupt_i , void* interrupt_addr){
  struct idt_desc * desc = & idt_descriptors[interrupt_i];    // abbr. to 'desc'
  desc->offset_lo = (uint32_t) interrupt_addr & 0x0000ffff;
  desc->selector = KERNEL_CODE_SELECTOR;
  desc->zero = 0 ;
  desc->type_attr = 0xee;    // b/c we are working with an i386 32-bit interrupt gate 
}

// Initializes IDT w/ 0's : 
void idt_init()
{
  memset( idt_descriptors , 0 , sizeof(idt_descriptors) );
  idtr_descriptor.limit = sizeof(idt_descriptors) -1 ;
  idtr_descriptor.base = idt_descriptors; 
}
