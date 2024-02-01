#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char** argv) {
    int max = -1;
    int bytesInMB = 1048576;

    if(argc > 1)
        max = atoi(argv[1]);

    int counter = 0;
    char* address;

    // malloc'ing up to 1000 MB, 1 MB at a time. 
    while(counter != max) {
        //ask OS for 1MB of memory (again) : more in the heap , new addr. 
        address = malloc(bytesInMB);
        //if given memory, fill with 0s
        if(address != NULL) {
            memset(address, 0, bytesInMB);
        }
        counter++;
        //print every 100MBs
        if(counter%100==0){
            printf("Allocated %d MB\n", counter);
        }
    }

    /* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       HOW DO WE (OR CAN WE) RELEASE 1 GB IN THE HEAP ? 
       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    */

    return 0;
}
