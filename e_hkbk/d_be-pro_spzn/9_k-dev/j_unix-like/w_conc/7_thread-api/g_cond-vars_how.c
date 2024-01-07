/*
Condition variable :
. THE IDEA : complete obstruction of process/threads until a condition is satisfied
. CALLING THREAD : the main thread - the one that locks/unlocks and can have the critical section all to itself. 
. How it works :
*/
//====================================================================================================================
    pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;	 
    pthread_cond_t cond = PTHREAD_COND_INITIALIZER; 	 


    // ---------------------------- LOCK UP , CALLING THREAD IN ----------------------------------
    pthread_mutex_lock(&lock); 
    // -------------------------------------------------------------------------------------------


    // --------------- ACCESSING/MODIFYING DATA ... DOING WHAT MUST BE DONE ... ------------------


    // ---------------------- SOMETHING IS OFF AT THIS POINT OF PROCESS --------------------------
    // ---- SEND WAIT CALL : CALL.THREAD RELEASES THE MUTEX , LETS IN OTHER THREADS , SLEEPS -----
    // ------------- EITHER OTHER THREADS CHANGE THE CONDITION OR ALSO GO TO SLEEP  --------------
    |
    while (ready == 0)			 // the barring flag that threads share @ mutex release  
      pthread_cond_wait(&cond, &lock);	 // the WAIT CALL : mutex and cond.var are linked. 
//====================================================================================================================
    pthread_mutex_lock(&lock);
    ready = 1;				// BARRING FLAG - declare all good 
    pthread_cond_signal(&cond);		// SIGNAL CALL - tell the calling thread to wake up 
    pthread_mutex_unlock(&lock);
//====================================================================================================================    
    // (1) SEND cond SIGNAL , (2) HAVE barring flag GIVE OK. 
    // Calling thread reacqs mutex. Then , ... 


    pthread_mutex_unlock(&lock);    // calling thread releases mutex : reacq again , block other threads here 
    pthread_mutex_lock(&lock);      // reacqs mutex to block other threads here
        // may recheck the barring flag and the condition variable 
	// may continue working on shared data 
    pthread_mutex_unlock(&lock);    // calling thread releases mutex , just in time for end of crit.section.  
//====================================================================================================================
//
