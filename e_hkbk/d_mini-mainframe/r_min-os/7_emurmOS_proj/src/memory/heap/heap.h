#ifndef HEAP_H
#define HEAP_H
#include "config.h"
#include <stdint.h>
#include <stddef.h>

//##############################################################
//########## BITMASKS TO OP WITH HEAP_TABLE_ENTRIES : ##########
//##############################################################

#define HPBLOCK_CONT   0b10000000
#define HPBLOCK_FIRST  0b01000000
// bit unassigned      0b00100000
// bit unassigned      0b00010000
// bit unassigned      0b00001000
// bit unassigned      0b00000100
// bit unassigned      0b00000010
#define HPBLOCK_TAKEN  0b00000001 
#define HPBLOCK_FREE   0b00000000

//##############################################################
//######################## DATA TYPES : ########################
//##############################################################

typedef unsigned char    entry ;
//
struct heap_table {
  entry * origin;    // address of table 
  size_t num_entries;    // ?? max ?? currently alloc'd ?? 
};

struct heap_manager {
  struct heap_table * table;
  void * start_addr; 
};

//##############################################################

#endif
