#include "idt.h"
#include "config.h"
#include "kernel.h"
#include "memory/memory.h"
#include "io/io.h"

/*##########################################################################################*/

struct idt_desc idt[NUM_INTERRUPTS];
struct idtr_desc idtr_descriptor;    // about the table itself 

extern void idt_load(struct idtr_desc * ptr);    // just to call lidt <= load idt.info_addr <= CPU needs to know about the IDT. 
                                                 // Compile-time security ?
extern void no_int_atomic();
extern void int_21h_atomic();
/*##########################################################################################*/

void no_int_handle(){
  outb(0x20 , 0x20);    // int ack (port , val_int) to PIC   
}

// INTERRUPT HANDLER - whose address can be passed to idt_set() function : 
void int_00h_handle(){
  printstr("ERROR : DIV/0\n");
}

void int_21h_handle(){
  printstr("Keyboard pressed!\n");
  outb(0x20 , 0x20);    // int ack (port , val_int) to PIC 
}

/*##########################################################################################*/

// Helps set interrupts and their addresses within IDT ,
// maps interrupt indices to interrupt addresses : 
void idt_set(int interrupt_i , void* interrupt_addr){
  struct idt_desc * idesc = & idt[interrupt_i];    // abbr. to 'idesc'
  
  idesc->offset_lo = (uint32_t) interrupt_addr & 0x0000FFFF;
  idesc->selector = KERNEL_CODE_SELECTOR;
  idesc->zero = 0 ;
  idesc->type_attr = 0xEE;    // b/c we are working with an i386 32-bit interrupt gate ;
                              // interrupt will be used by user processes.
  idesc->offset_hi = (uint32_t) interrupt_addr >> 16;
}

/*##########################################################################################*/

// Initializes IDT w/ 0's : 
void idt_init()
{
  memset( idt , 0 , sizeof(idt) );
  idtr_descriptor.limit = sizeof(idt) -1 ;    // index of final byte in IDTR descriptor 
  idtr_descriptor.base = (uint32_t) idt;      // This could be re-implemented as a pointer. 
                                              // Reminder : in C arrays are accessed/returned as pointers.

  for(int i=0 ; i<NUM_INTERRUPTS ; i++){
    idt_set(i , no_int_atomic);
  }
  // Map interrupt indices to interrupt handlers (addresses). 
  idt_set(0x00 , int_00h_handle);
  idt_set(0x21 , int_21h_atomic);
  // Mapping MUST take place before `[IDTR]` is loaded. 
  
  idt_load( & idtr_descriptor );
}
