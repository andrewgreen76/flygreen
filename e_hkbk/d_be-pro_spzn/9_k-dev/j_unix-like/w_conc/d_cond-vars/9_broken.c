// This code does not work for 2 prods / 2 cons per thread. 

/*
  ====================================================================
  BOUNDED BUFFER PROBLEM : 
   . e.g., a producer says one thing , a consumer encounters something else 
  ====================================================================
*/

int loops; // put-displace N times 
cond_t cond;
mutex_t mutex;
int full = 0; 

// ==================== aux. functions : ====================

void put(int value) {
    assert(full == 0);
    full = 1;
    buffer = value;
}


int get() {
    assert(full == 1);
    full = 0;    // mark as empty 
    return buffer;
}

// =================== THREAD FUNCTIONS : ===================

void *producer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex); // p1   // One producer thread at a time (scales on multi-CPU , prt-chd per CPU). 
   
    if (full == 1) // p2
      Pthread_cond_wait(&cond, &mutex); // p3 // Full ? Sleep , do not waste CPU , fire off a thread to resolve this. 
    
    put(i); // p4 // FILLS buffer 
    Pthread_cond_signal(&cond); // p5
    Pthread_mutex_unlock(&mutex); // p6
  }
}

void *consumer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex); // c1
    
    if (full == 0) // c2
      Pthread_cond_wait(&cond, &mutex); // c3 // wait() releases the lock. 
    
    int tmp = get(); // c4 // EMPTIES buffer 
    Pthread_cond_signal(&cond); // c5
    Pthread_mutex_unlock(&mutex); // c6
    printf("%d\n", tmp);
  }
}
