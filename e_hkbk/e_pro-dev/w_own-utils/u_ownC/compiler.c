
// Core compiler routines.
//
// int flags : terms of compiling. Are we creating obj or exe ? 

#include "compiler.h"

int fcompile(char * ifname , char * ofname , int flags){

  struct cmpl_process * cmproc = cmpl_process_create(ifname , ofname , flags);
  if(!cmproc) return CMPL_FAILURE;

  // Lex.anls : 
  // Parsing -> AST : 
  // Code generation + validation : 
  
  return CMPL_SUCCESS;
}
