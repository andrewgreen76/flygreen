#ifndef HEAP_H
#define HEAP_H
#include "config.h"
#include <stdint.h>
#include <stddef.h>

// Bitmasks to op with heap_table_entries :
//
#define MORE_IN_GROUP  0b10000000
#define FIRST_IN_GROUP 0b01000000
// bit unassigned      0b00100000
// bit unassigned      0b00010000
// bit unassigned      0b00001000
// bit unassigned      0b00000100
// bit unassigned      0b00000010
#define HEAPBLK_TAKEN  0b00000001 
#define HEAPBLK_FREE   0b00000000

typedef unsigned char HEAPBLK_ENTRY ;

#endif
