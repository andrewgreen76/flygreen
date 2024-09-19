
#include <stdio.h>

struct test{
	int n;
	char a;
	char b;
	char c;
	char d;
	//char m;
};

extern struct test my_asm();

int main(int argc , char ** argv) 
{
	struct test s = my_asm();
	printf("%i %c %c %c %c", s.n, s.a, s.b, s.c, s.d);

	return 0;
}
