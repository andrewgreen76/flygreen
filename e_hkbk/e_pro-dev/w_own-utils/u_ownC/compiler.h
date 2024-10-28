
// Compiler-related structures for : tokens , nodes , etc. 

#ifndef COMPILER_H
#define COMPILER_H

#define CMPL_SUCCESS 0
#define CMPL_FAILURE 1

#include <stdio.h>
#include <stdlib.h>

/*********************************** STRUCTURES **********************************/

typedef struct {
   FILE * fid;
   char * abspath;
} cmpl_file ;

typedef struct {
  // Flags for terms of file compilation. 
  int flags;
  
  cmpl_file ifile;
  cmpl_file ofile;
  
} cmpl_process ;

/*********************************** PROTOTYPES **********************************/

int fcompile( char * ifname ,  char * ofname , int flags);
cmpl_process * cmpl_process_create(char * ifname ,  char * ofname , int flags);

#endif
