
// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

cmpl_process * cmpl_process_create(char * ifname ,  char * ofname , int flags){
  
  FILE * ifile = fopen(ifname , "r");
  if(!ifile) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * ofile = NULL;
  if(ofname){    // if (nameprovided) ? to output file : to terminal. 
    ofile = fopen(ofname , "w");
    if(!ofile) return NULL;    // If bad path or bad permissions. 
  }

  
  cmpl_process * cmproc = calloc(1 , sizeof(cmpl_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  cmproc->flags = flags;
  cmproc->ifile.fp = ifile;
  cmproc->ofile = ofile;

  return cmproc; 
}
