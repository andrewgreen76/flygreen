#define _CRT_SECURE_NO_WARNINGS 1

/* Severity	Code	Description	Project	File	Line	Suppression State
Error	C4996	'strcpy': This function or variable may be unsafe. 
Consider using strcpy_s instead. To disable deprecation, use _CRT_SECURE_NO_WARNINGS. See online help for details.	
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <alloc.h> 
/* what is alloc.h? 
It's a header file that declares memory-management functions like malloc , free , realloc . 
That header file is deprecated. For C use #include <stdlib.h>. */
#include <conio.h>
#include <dos.h>
//#include <mem.h>
/* The <mem.h> Header File. Routines for manipulation of memory blocks. 
 Are you trying to compile some Borland C++ based source code? 
 The header files are not the same between Borland and Visual C++ compilers.
 */



int main() 
{
	char str[50];

	strcpy(str, "This is string.h library function");
	puts(str);
	memset(str, '$', 7);
	puts(str);

	return 0;
}


/* void *memset(void *str, int c, size_t n)

The C library function void *memset(void *str, int c, size_t n)
 - copies the character c (an unsigned char) to the first n characters of the string pointed to, by the argument str.

Parameters:
str - This is a pointer to the block of memory to fill.

c - This is the value to be set. The value is passed as an int, but the function fills the block of memory
	using the unsigned char conversion of this value.

n - This is the number of bytes to be set to the value.

Return Value
This function returns a pointer to the memory area str.

*/