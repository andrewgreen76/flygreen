// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

cmpl_process * cmpl_process_create( char * ifname ,  char * ofname , int flags){
  
  FILE * ifile = fopen(ifname , "r");
  if(!ifile) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * ofile = NULL;
  if(ofname){    // if (nameprovided) ? to output file : to terminal. 
    ofile = fopen(ofname , "w");
    if(!ofile) return NULL;    // If out fname not provided , maybe we'll write to terminal instead of file. 
  }

  
  cmpl_process * cmpl_process_a = calloc(1 , sizeof(cmpl_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  cmpl_process_a->flags = flags;
  cmpl_process_a->cm_file.fp = ifile;
x  cmpl_process_a->out_file = ofile;

  return cpr; 
}
