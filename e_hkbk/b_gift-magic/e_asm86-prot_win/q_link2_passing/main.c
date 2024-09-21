
#include <stdio.h>

struct test{
	char buf[30];
};

extern int my_asm(struct test t);	// linking ; proto for callee returning buf_addr to `struct test s`.

int main(int argc , char ** argv) 
{
	struct test t;
	t.buf[0] = 'A';
	t.buf[1] = 'B';
	t.buf[2] = 'C';
	printf( "%c\n", (char)my_asm(t) );

	return 0;
}
