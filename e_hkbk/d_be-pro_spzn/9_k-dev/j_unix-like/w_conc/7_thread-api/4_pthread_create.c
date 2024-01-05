#include <pthread.h>

int pthread_create (pthread_t *thread,  
		    const pthread_attr_t *attr,
		    	  // addr of attributes  : stack size , sched.priority , properties , etc.
			  // pthread_attr_init() : a separate call that inits every attribute if not NULL 
		    void *(*start_routine)(void*), 
		        /*
			  ^ This is a function pointer to the function that will be executed by the new thread. 
			    The function takes a single void* argument and returns a void*. This is a common signature 
			    for thread start routines in POSIX threads.
			 */
		    void *arg);

//
