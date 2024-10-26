// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

struct cc_proc * ccproc_create(const char * in_fname , const char * out_fname , int flags){
  
  FILE * in_file = fopen(in_fname , "r");
  if(!in_file) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * out_file = NULL;
  if(out_fname){    // if output filename provided
    out_file = fopen(out_fname , "w");
    if(!out_file) return NULL;    // If out fname not provided , maybe we'll write to term instead of file. 
  }

  struct ccproc * process = calloc(1 , sizeof(struct ccproc) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  process->flags = flags;
  process->cmpl_file.fp = in_file;
  process->out_file = out_file;

  return process;   
}
