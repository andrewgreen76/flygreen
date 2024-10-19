
#include <stdio.h>

struct test{
	char buf[30];
};

extern struct test my_asm();	// linking ; proto for callee returning buf_addr to `struct test s`.

int main(int argc , char ** argv) 
{
	struct test s = my_asm();	// ASM callee is written to compute , access , and ret buf_addr. 
								// Instead of ret 'A' in EAX , we ret buf_addr (mov eax , [esp+8]). 
								// In ASM callee we are not just (1) returning buf_addr ; 
								// we are also (2) writing to the 1st byte. 
	printf("%c", s.buf[0]);

	return 0;
}
