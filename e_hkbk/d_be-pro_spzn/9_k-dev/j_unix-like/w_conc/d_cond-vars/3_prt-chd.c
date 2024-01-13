/*
  When the context switches to the spinning parent thread 
   => the spinning wastes CPU time. 
   . sometimes erroneous logic is followed 
*/

#include <stdio.h>
#include <pthread.h>

volatile int done = 0;

void *child(void *arg) {
    printf("child\n");
    done = 1;
    return NULL;
}


int main(int argc, char *argv[]) {
    printf("parent: begin\n");
    pthread_t c;
    Pthread_create(&c, NULL, child, NULL); // create child
    
    while (done == 0)
    ; // spin
    
    printf("parent: end\n");
    return 0;
}
