#include <stdio.h> 

/* Handle exceptions related to: 
 *  - filenames / (non)existing files 
 *  - exiting methods 
 * */

/* lifeloop flags: 
 * 0 - post-input single-process decision-making 
 * 1 - continuous decision-making 
 * */

/* thought flags: 
 * thk2conOn - every simple thought goes to console 
 *  - define "simple" 
 * */

struct excHandler 
{
	int fileFail; 
	int loopFail; 
}; 

struct excHandler eh;



int main(int argc, char *argv[])
{
	printf("\nHello, world.\n\n");
	//runLifeLoop(); 
	return 0;
}
