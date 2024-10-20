// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>

struct cmplproc * cmplproc_create(const char * in_fname , const char * out_fname , int flags){
  FILE * in_file = fopen(in_fname , "r");
  if(!in_file) return NULL;    // Right now by default the function returns NULL upon failure. 

  
  FILE * out_file = NULL;
  if(out_fname){
    out_file = fopen(out_fname , "w");
    if(!out_file) return NULL;    // Maybe we'll write to term instead of file. 
  }

  struct cmplproc * process = calloc(1 , sizeof(struct cmplproc) );
  
}
