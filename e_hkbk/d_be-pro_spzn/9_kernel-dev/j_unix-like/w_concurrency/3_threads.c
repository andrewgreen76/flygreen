#include <stdio.h>
#include <assert.h>
#include <pthread.h>


void *mythread(void *arg) {
  printf("%s\n", (char *) arg);
  return NULL;
}


int main(int argc, char *argv[]) {
    
    pthread_t thread1, thread2;

    int rc;
    printf("In main before creating threads\n");

    // create two threads
    pthread_create(&thread1, NULL, mythread, "Thread1");
    pthread_create(&thread2, NULL, mythread, "Thread2");

    // wait for the threads to complete
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    printf("In main after running threads\n");

    return 0;
}
