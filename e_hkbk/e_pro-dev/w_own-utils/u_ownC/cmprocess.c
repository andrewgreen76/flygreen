// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

cmprocess * cmprocess_create( char * ifname ,  char * ofname , int flags){
  
  FILE * ifile = fopen(ifname , "r");
  if(!ifile) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * ofile = NULL;
  if(ofname){    // if (nameprovided) ? to output file : to terminal. 
    ofile = fopen(ofname , "w");
    if(!ofile) return NULL;    // If bad path or bad permissions. 
  }

  
  cmprocess * cmprocess_a = calloc(1 , sizeof(cmprocess) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  cmprocess_a->flags = flags;
  cmprocess_a->cm_file.fp = ifile;
  cmprocess_a->out_file = ofile;

  return cpr; 
}
