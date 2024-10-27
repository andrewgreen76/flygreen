
// Compiler-related structures for : tokens , nodes , etc. 

#ifndef COMPILER_H
#define COMPILER_H
#include <stdio.h>

/*********************************** STRUCTURES **********************************/

typedef struct {
  // Flags for terms of file compilation. 
  int flags

  typedef struct {
     FILE * fp;
     char * abspath;
  } cm_infile cm_infile_a;

  FILE * outfile;

} cmprocess;

/*********************************** PROTOTYPES **********************************/

int fcompile( char * infname ,  char * outfname , int flags);
cmprocess * cmprocess_a = calloc( 1 , sizeof(cmprocess) );    // calloc() rets ptr to memory , all init'd w/ 0's.

#endif
