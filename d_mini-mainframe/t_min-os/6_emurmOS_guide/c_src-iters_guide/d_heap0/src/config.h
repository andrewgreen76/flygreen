#ifndef CONFIG_H
#define CONFIG_H

#define KERNEL_CODE_SELECTOR 0x08 
#define KERNEL_DATA_SELECTOR 0x16

#define NUM_INTERRUPTS 512

#define HEAP_SIZE 104857600    // 100 MB 
#define HPBLOCK_SIZE 4096
#define HEAP_ADDR 0x01000000
#define HPTABLE_ADDR 0x00007E00 

#endif 