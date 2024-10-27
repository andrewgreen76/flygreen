
// Compiler-related structures for : tokens , nodes , etc. 

#ifndef COMPILER_H
#define COMPILER_H
#include <stdio.h>

/*********************************** STRUCTURES **********************************/

typedef struct {
  // Flags for terms of file compilation. 
  int flags

  typedef struct {
     FILE * fp;
     char * abspath;
  } cmproc_ifile cmproc_ifile_a;

  FILE * ofile;

} cmpl_process;

/*********************************** PROTOTYPES **********************************/

int fcompile( char * ifname ,  char * ofname , int flags);
cm_process * cmproc = calloc(1 , sizeof(cm_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
