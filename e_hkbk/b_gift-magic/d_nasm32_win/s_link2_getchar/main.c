
#include <stdio.h>

extern char my_asm();	// linking ; proto for callee returning buf_addr to `struct test s`.

int main(int argc , char ** argv) 
{
	char c = my_asm();
	printf( "%c\n", c );

	return 0;
}
