int done = 0;
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t c = PTHREAD_COND_INITIALIZER;

/*
  . thread T1 is on the move 
  . lock acquired 
  -> wait() 
     -> thread T1 goes to sleep 
     -> wait() releases the lock 
  -> another thread , T2 , satisfies a condition (resolves the barring flag) 
  -> 
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
    while (done == 0)
        Pthread_cond_wait(&c, &m); // WAIT : sleep , do not waste CPU time 
    Pthread_mutex_unlock(&m);
}


int main(int argc, char *argv[]) {
    printf("parent: begin\n");
    pthread_t p;
    
    Pthread_create(&p, NULL, child, NULL);
    thr_join();
    
    printf("parent: end\n");
    return 0;
}
