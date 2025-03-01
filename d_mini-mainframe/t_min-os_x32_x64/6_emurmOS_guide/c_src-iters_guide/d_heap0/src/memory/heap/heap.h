#ifndef HEAP_H
#define HEAP_H
#include "config.h"
#include <stdint.h>
#include <stddef.h>

//##############################################################
//########### BITMASKS - OP ON HEAP_TABLE_ENTRIES : ############
//##############################################################

#define HPBLOCK_CONT   0b10000000
#define HPBLOCK_FIRST  0b01000000
// bit unassigned      0b00100000
// bit unassigned      0b00010000
// bit unassigned      0b00001000
// bit unassigned      0b00000100
// bit unassigned      0b00000010
#define HPBLOCK_TAKEN  0b00000001
//
#define HPBLOCK_FREE   0b00000000

//##############################################################
//######################## DATA TYPES : ########################
//##############################################################

typedef unsigned char    heap_entry ;
//
struct heap_table {
  heap_entry * entries;  
  size_t max_entries;  
};

struct heap {
  struct heap_table * table; // for using the heap_table 
  void * base;                // for using the heap_memory 
};

//##############################################################
//####################### PROTOTYPES : #########################
//##############################################################

int heap_create(struct heap * hp , void * hp_pool_start , void * hp_end , struct heap_table * hp_table);

//##############################################################

#endif
