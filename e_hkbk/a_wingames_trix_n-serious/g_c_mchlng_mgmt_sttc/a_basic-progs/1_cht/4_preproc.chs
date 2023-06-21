
------------------- Basic C/C++ pre-processing directives: --------------------

#include ""	- includes a file (typically a header file). 
#define f() () 	- macro substitutes human-friendly tokens for actual code. 
#ifdef 		- checks if a var under #defined token has a value. 
#pragma 	- requests info, impl. for the compiler (optimization, etc.). 
#pragma once  	- one-time inclusion, checks if file already included; 
		  (not a standard, but widely supported and used directive). 
Used in-code:
|
#if 		- checks for verity during take 1. 
#elif		- else-if at pre-processing. 
#endif		- closes #if / #ifdef. 
#error		- stops pre-processing under certain conditions 
		  (with #if / #endif). 

