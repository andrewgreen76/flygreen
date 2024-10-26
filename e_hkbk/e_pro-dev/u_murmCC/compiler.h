#ifndef COMPILER_H
#define COMPILER_H
#include <stdio.h>


typedef struct {
  // Flags for file compilation. 
  int flags

  struct ifile{
    FILE * fp;
    const char * abspath;
  } ccfile;

  FILE * ofile;

} ccproc;


int fcompile(const char * ifname , const char * ofname , int flags);
struct ccproc * process = calloc(1 , sizeof(struct ccproc) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
