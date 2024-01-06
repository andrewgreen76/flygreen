/*
timedlock :
. quite simply , a timed lock
. timeout : a lock has been on a critical section for too long
. how it works :
  . abstime.tv_sec = lock init/acquisition time (ends in secs) 
  . update abstime = time to check on the lock (ends in secs)
  . start a regular timedlock with :
    int result = pthread_mutex_timedlock(&my_mutex, &abstime); 
  . if still locked , returns EBUSY error code 
|
|
. trylock : 
  . this timedlock gets a thread to attempt to acquire a lock immediately ("timeout = 0") 
  . if the lock is held by another thread , the attempting thread will give up , simply return , and pass the critical section
  . start a trylock with : 
    int result = pthread_mutex_timedlock(&my_mutex, NULL);
  . if locked , returns EBUSY error code 
 */

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
  int pthread_mutex_timedlock(pthread_mutex_t *mutex, const struct timespec *abstime);
 */

int main() {
    pthread_mutex_t my_mutex;

    // Initialize the mutex
    if (pthread_mutex_init(&my_mutex, NULL) != 0) {
        fprintf(stderr, "Mutex initialization failed\n");
        return 1;
    }

    // Set an absolute time for the timeout
    struct timespec abstime;
    clock_gettime(CLOCK_REALTIME, &abstime);
    abstime.tv_sec += 5;  // Set a timeout of 5 seconds

    // Attempt to lock the mutex with a timeout
    int result = pthread_mutex_timedlock(&my_mutex, &abstime);

    if (result == 0) {
        // Mutex successfully locked, perform critical section

        // Don't forget to unlock the mutex when done
        pthread_mutex_unlock(&my_mutex);

        // Continue with the rest of the program
    } else if (result == ETIMEDOUT) {
        // Lock attempt timed out

        fprintf(stderr, "Mutex lock attempt timed out\n");

        // Handle the timeout or return from the function
    } else {
        // Other error occurred

        fprintf(stderr, "Mutex lock attempt failed with error code %d\n", result);

        // Handle the error or return from the function
    }

    // Destroy the mutex when done
    pthread_mutex_destroy(&my_mutex);

    return 0;
}
