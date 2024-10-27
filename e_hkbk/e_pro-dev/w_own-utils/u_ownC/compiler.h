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
  } icc_file;

  FILE * ofile;

} icc_process;

/*********************************** PROTOTYPES **********************************/

int fcompile(const char * ifname , const char * ofname , int flags);
icc_process * iccproc = calloc(1 , sizeof(icc_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
