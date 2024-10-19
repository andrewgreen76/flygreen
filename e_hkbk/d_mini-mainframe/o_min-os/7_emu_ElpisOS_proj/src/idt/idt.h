#ifndef IDT_H
#define IDT_H

#include <stdint.h>


// Info ABOUT INTERRUPT : 
struct idt_desc{
  uint16_t offset_lo;    // offset bits 0-15 
  uint16_t selector;    // kernel code selector in GDT (NOT IDT ; this is a CODE SELECTOR)
  uint8_t zero;         // --- No purpose. --- 
  uint8_t type_attr;    // descriptor type 
  uint16_t offset_hi;    // 48-63 : offset bits 16-31 
} __attribute__((packed));


// Info ABOUT INTERRUPT COLLECTION (= IDT , the array of int descriptors) : 
struct idtr_desc{
  uint16_t limit;    // size of IDT-1 // {100h->1000h} // can support up to 512 interrupts 
  uint32_t base;     // base of IDT 
} __attribute__((packed));


void idt_init();

  
#endif
