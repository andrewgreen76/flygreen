int done = 0;
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t c = PTHREAD_COND_INITIALIZER;

/*
  . T1 is on the move 
  -> T1 acquires the lock  
  -> wait() 
     -> thread T1 goes to sleep 
     -> wait() releases the lock 
  -> T2 satisfies a condition (resolves the barring flag) , 
  -> T2 wakes up T1 
  -> T1 acquires the lock again      
*/

void thr_exit() {
    Pthread_mutex_lock(&m);
    done = 1;
    Pthread_cond_signal(&c);    // SIGNAL : wake up 
    Pthread_mutex_unlock(&m);
}


void *child(void *arg) {
    printf("child\n");
    thr_exit();
    return NULL;
}


void thr_join() {
    Pthread_mutex_lock(&m);
    while (done == 0)  // If child flips the flag before signaling , it will solve the signal-before-wait problem (race). 
        Pthread_cond_wait(&c, &m); // WAIT : sleep , do not waste CPU time 
    Pthread_mutex_unlock(&m);
}

/*
  This is a reminder that lock/unlock allows for execution of only one thing at a time. Other threads line up and wait. 
*/

int main(int argc, char *argv[]) {
    printf("parent: begin\n");
    pthread_t p;
    
    Pthread_create(&p, NULL, child, NULL);
    thr_join();
    
    printf("parent: end\n");
    return 0;
}
