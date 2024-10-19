#include "idt.h"
#include "config.h"
#include "memory/memory.h"

struct idt_desc idt[NUM_INTERRUPTS];
struct idtr_desc idtr_descriptor;    // about the table itself 

extern void idt_load(struct idtr_desc * ptr);    // just to call lidt <= load idt.info_addr <= CPU needs to know about the IDT. 
                                                 // Compile-time security ? 

void idt_zero(){
  printstr("ERROR : DIV/0\n");
}

// Helps set interrupts and their addresses within IDT : 
void idt_set(int interrupt_i , void* interrupt_addr){
  struct idt_desc * desc = & idt[interrupt_i];    // abbr. to 'desc'
  desc->offset_lo = (uint32_t) interrupt_addr & 0x0000FFFF;
  desc->selector = KERNEL_CODE_SELECTOR;
  desc->zero = 0 ;
  desc->type_attr = 0xEE;    // b/c we are working with an i386 32-bit interrupt gate ;
                             // interrupt will be used by user processes.
  desc->offset_hi = (uint32_t) interrupt_addr >> 16;
}

// Initializes IDT w/ 0's : 
void idt_init()
{
  memset( idt , 0 , sizeof(idt) );
  idtr_descriptor.limit = sizeof(idt) -1 ;    // index of final byte in IDTR descriptor 
  idtr_descriptor.base = idt;

  idt_set(0 , idt_zero);
  idt_load( & idtr_descriptor );
}
