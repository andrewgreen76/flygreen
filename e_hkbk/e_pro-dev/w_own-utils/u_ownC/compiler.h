
// Compiler-related structures for : tokens , nodes , etc. 

#ifndef COMPILER_H
#define COMPILER_H

#define CMPL_SUCCESS 0
#define CMPL_FAILURE 1

#include <stdio.h>

/*********************************** STRUCTURES **********************************/

typedef struct {
  // Flags for terms of file compilation. 
  int flags;

  typedef struct {
     FILE * fp;
     char * abspath;
  } cmpl_ifile ifile;

  FILE * ofile;

} cmpl_process;

/*********************************** PROTOTYPES **********************************/

int fcompile( char * ifname ,  char * ofname , int flags);
cmpl_process * cmproc = calloc( 1 , sizeof(cmpl_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
