
#include <stdio.h>
extern int my_asm(int a , int b);

int main(int argc , char ** argv) 
{
	int r = my_asm(5, 10);	// eax holds '1' by default , so that val will be ret'd.
	printf("Value: %i\n", r);
	return 0;
}
