#ifndef COMPILER_H
#define COMPILER_H
#include <stdio.h>


struct cmpl_proc{
  // Flags for file compilation. 
  int flags

  struct cmpl_proc_infile{
    FILE * fp;
    const char * abspath;
  } cmpl_file;

  FILE * out_file;

};


int fcompile(const char * in_fname , const char * out_fname , int flags);


#endif
