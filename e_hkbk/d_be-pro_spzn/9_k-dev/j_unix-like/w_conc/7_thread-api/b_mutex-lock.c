
// lock_t  type - applicable in legacy system environments such as System V
// mutex_t type - exclusive to the more modern POSIX threads 

#include <pthread.h>

/*
  int pthread_mutex_lock(pthread_mutex_t *mutex); 
  int pthread_mutex_unlock(pthread_mutex_t *mutex);
 */
    //================================== INIT ==================================
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


    int x = 0;
    //================================== LOCK ==================================
    int rc = pthread_mutex_lock(&lock); // "acquiring a lock on a mutex"
                                        // any other thread that attempts to acquire the lock has to wait 
    assert( !rc );                      // obligatory error-handling
                                        /* If rets err.code (non-zero), the mutex is either ... 
                                           . not initialized 
					   . destroyed 
					   . locked by another thread 
					   If not OK'd but used for another thread => race. 
					*/
    //================================= UNLOCK =================================
    x = x + 1; // or whatever your critical section is
    pthread_mutex_unlock(&lock);
    //================================ DESTROY =================================
    pthread_mutex_destroy(&lock); 


/*
  Threads wait in the lock acquisition function. 
*/
