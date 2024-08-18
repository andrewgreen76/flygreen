/*
  "We normally create multiple threads and wait for them to finish" instead of using pthread_join(). 
  . "To ensure that all work is completed before departing or going on to the next step of computation, 
     a parallel program may typically employ join."
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct { int a; int b; } myarg_t;
typedef struct { int x; int y; } myret_t;

void *mythread(void *arg) {
    myarg_t *args = (myarg_t *) arg;
    printf("%d %d\n", args->a, args->b);
    myret_t oops; // ALLOCATED ON STACK: BAD!
    oops.x = 1;
    oops.y = 2;
    return (void *) &oops;
}

int main(int argc, char *argv[]) {
    pthread_t p;
    myret_t *rvals;
    myarg_t args = { 10, 20 };
    pthread_create(&p, NULL, mythread, &args); /* 4th para reflects the arg of thread_func
						  . can be NULL, but then : thread_func(VOID * arg) 
						*/
    
    pthread_join(p, (void **) &rvals);         /* 2nd para reflects the ret type of thread_func
						  . can be NULL, but then : VOID * thread_func(void * arg)
						*/
    printf("returned %d %d\n", rvals->x, rvals->y);
    free(rvals);
    return 0;
}
