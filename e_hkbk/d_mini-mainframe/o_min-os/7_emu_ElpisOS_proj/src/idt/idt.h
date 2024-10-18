#ifndef IDT_H
#define IDT_H


struct idt_desc{
  uint16_t offset_lo;    // offset 0-15 bits
  uint16_t selector;    // kernel code selector in GDT (NOT IDT ; this is a CODE SELECTOR)
  uint8_t zero;         // --- No purpose. --- 
  uint8_t type_attr;    // descriptor type 
  uint16_t offset_hi;    // offset 48-63 bits
} __attribute__((packed));


struct idtr_desc{
  uint16_t limit;    // size of IDT-1
  uint32_t base;     // base of IDT 
} __attribute__((packed));


#endif
