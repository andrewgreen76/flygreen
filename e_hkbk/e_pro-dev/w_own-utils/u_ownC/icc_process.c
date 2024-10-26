// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

struct icc_process * icc_process_create(const char * ifname , const char * ofname , int flags){
  
  FILE * ifile = fopen(ifname , "r");
  if(!in_file) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * ofile = NULL;
  if(ofname){    // if output filename provided
    ofile = fopen(ofname , "w");
    if(!ofile) return NULL;    // If out fname not provided , maybe we'll write to term instead of file. 
  }

  struct ccproc * ccpr = calloc(1 , sizeof(struct ccproc) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  process->flags = flags;
  process->cmpl_file.fp = in_file;
  process->out_file = out_file;

  return process;   
}
