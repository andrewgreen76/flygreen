// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

cmproc * cmproc_create( char * ifname ,  char * ofname , int flags){
  
  FILE * ifile = fopen(ifname , "r");
  if(!ifile) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * ofile = NULL;
  if(ofname){    // if (nameprovided) ? to output file : to terminal. 
    ofile = fopen(ofname , "w");
    if(!ofile) return NULL;    // If out fname not provided , maybe we'll write to terminal instead of file. 
  }

  
  cmproc * cmproc_a = calloc(1 , sizeof(cmproc) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  cmproc_a->flags = flags;
  cmproc_a->cm_file.fp = ifile;
  cmproc_a->out_file = ofile;

  return cpr; 
}
