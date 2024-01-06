#include <pthread.h>

/*
  int pthread_mutex_lock(pthread_mutex_t *mutex);
  int pthread_mutex_unlock(pthread_mutex_t *mutex);
 */

    // INIT : 
    // 
    // Locks must be properly initialized. Two methods : 
    //
    // Method (1) - every lock has an assigned value : 
    pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
    //
    // Method (2) - dynamic assignment : 
    pthread_mutex_t lock;
    assert( !pthread_mutex_init(&lock, NULL) ); // always check success!
                                      // ^ Properties/attributes : zzz 

    ////////////////////////////////////////////////////////////////////////////////
    int x = 0; 

    // LOCK
    pthread_mutex_lock(&lock);
    // UNLOCK 
    x = x + 1; // or whatever your critical section is
    pthread_mutex_unlock(&lock);
    // DESTROY 
    pthread_mutex_destroy(&lock); 


/*
  Threads wait in the lock acquisition function. 
*/
