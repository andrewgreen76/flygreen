
// Compiler-related structures for : tokens , nodes , etc. 

#ifndef COMPILER_H
#define COMPILER_H

#define CMPL_SUCCESS 0
#define CMPL_FAILURE 1

#include <stdio.h>
#include <stdlib.h>

/*********************************** STRUCTURES **********************************/

struct cmpl_process {
  // Flags for terms of file compilation. 
  int flags;

  struct cmpl_ifile {
     FILE * fp;
     char * abspath;
  } ifile;

  FILE * ofile;

};

/*********************************** PROTOTYPES **********************************/

int fcompile( char * ifname ,  char * ofname , int flags);
struct cmpl_process * cmpl_process_create(char * ifname ,  char * ofname , int flags);

#endif
