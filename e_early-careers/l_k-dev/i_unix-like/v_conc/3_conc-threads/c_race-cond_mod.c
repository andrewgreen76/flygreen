/*
  Problem output : The counter variable ends up being less than 20,000,000 and it's different every time. 
  . Reason : data race condition. 
 */

#include <stdio.h>
#include <pthread.h>

static volatile int counter = 0;


// Simply adds 1 to counter repeatedly, in a loop
 //
void *mythread(void *arg) {
   printf("%s: begin\n", (char *) arg);
      int i;
      for (i = 0; i < 1e7; i++) {
	 counter = counter + 1;
      }
   printf("%s: done\n", (char *) arg);
   return NULL;
}

// main() : Just launches two threads (pthread_create) and then waits for them (pthread_join)

int main(int argc, char *argv[]) {
   pthread_t p1, p2;
   printf("main: begin (counter = %d)\n", counter);
   pthread_create(&p1, NULL, mythread, "A");
   pthread_create(&p2, NULL, mythread, "B");

   // join waits for the threads to finish
   pthread_join(p1, NULL);
   pthread_join(p2, NULL);
   printf("main: done with both (counter = %d)\n", counter);
   return 0;
}