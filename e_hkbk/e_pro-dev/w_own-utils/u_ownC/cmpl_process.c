
// Management of compiler processes.

#include <stdio.h>
#include <stdlib.h>
#include "compiler.h"

cmpl_process * cmpl_process_create(char * ifname ,  char * ofname , int flags){
  
  FILE * ifid = fopen(ifname , "r");
  if(!ifid) return NULL;    // No such file to compile - Right now by default the function returns NULL upon failure. 

  
  FILE * ofid = NULL;
  if(ofname){    // if (nameprovided) ? to output file : to terminal. 
    ofid = fopen(ofname , "w");
    if(!ofid) return NULL;    // If bad path or bad permissions. 
  }

  
  cmpl_process * cmproc = calloc(1 , sizeof(cmpl_process) );    // calloc() rets ptr to memory , all init'd w/ 0's.
  cmproc->flags = flags;
  cmproc->ifile.fid = ifid;
  cmproc->ofile.fid = ofid;

  
  return cmproc; 
}
