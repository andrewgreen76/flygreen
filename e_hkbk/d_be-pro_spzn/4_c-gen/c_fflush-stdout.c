/* 
   This is absolutely needed for certain C compilers. 
   . fflush(stdout);    // Forces the input buffer content to be unloaded (onto the indicated data stream (here stdout for the terminal) ). 
   . return 0;          // Forces the flushing of all buffers. 
*/

#include <stdio.h>

int main(){
	char familyName[50];
	char firstName[50];
	int age;
	printf("What is your family name?");
	fflush(stdout);
	scanf("%s", familyName);
	printf("What is your first name?");
	fflush(stdout);
	scanf("%s", firstName);
	printf("What is your age?");
	fflush(stdout);
	scanf("%d", &age);
	printf("%s %s %d\n", familyName,firstName,age);
	return 0;
}
