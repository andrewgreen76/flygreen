
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

} cmproc;

/*********************************** PROTOTYPES **********************************/

int fcompile( char * ifname ,  char * ofname , int flags);
cmproc * cmproc_a = calloc(1 , sizeof(cmproc) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
