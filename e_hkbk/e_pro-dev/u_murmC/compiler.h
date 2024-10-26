#ifndef COMPILER_H
#define COMPILER_H
#include <stdio.h>


struct ccproc{
  // Flags for file compilation. 
  int flags

  struct infile{
    FILE * fptr;
    const char * abspath;
  } ccfile;

  FILE * outfile;

};


int fcompile(const char * ifname , const char * ofname , int flags);
struct ccproc * process = calloc(1 , sizeof(struct ccproc) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
