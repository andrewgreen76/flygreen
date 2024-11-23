
#include <stdio.h>

struct test{
	char buf[30];
};

extern int my_asm(int * p);	// linking ; proto for callee returning buf_addr to `struct test s`.

int main(int argc , char ** argv) 
{
	int a = 50;
	int * ptr = &a;
	printf( "%i\n", my_asm(ptr) );

	return 0;
}
