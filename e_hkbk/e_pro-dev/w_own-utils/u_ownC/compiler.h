
// Compiler-related structures for : tokens , nodes , etc. 

#ifndef COMPILER_H
#define COMPILER_H
#include <stdio.h>

/*********************************** STRUCTURES **********************************/

typedef struct {
  // Flags for file compilation. 
  int flags

  struct ifile{
    FILE * fp;
    const char * abspath;
  } cm_file;

  FILE * ofile;

} cm_process;

/*********************************** PROTOTYPES **********************************/

int fcompile( char * ifname ,  char * ofname , int flags);
cm_process * cmproc = calloc(1 , sizeof(cm_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
