
#include <stdio.h>
extern int my_asm();

int main(int argc , char ** argv) 
{
	int r = my_asm();	// eax holds '1' by default , so that val will be ret'd.
	printf("Value: %i\n", r);
	return 0;
}
