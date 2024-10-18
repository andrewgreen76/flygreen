#include "idt.h"
#include "config.h"
#include "memory/memory.h"

struct idt_desc idt_descriptors[NUM_INTS];
struct idtr_desc idtr_descriptor;

void idt_init()
{
  memset( idt_descriptors , 0 , sizeof(idt_descriptors) );
  idtr_descriptor.limit = sizeof(idt_descriptors) -1 ;
  idtr_descriptor.base = idt_descriptors; 
}
