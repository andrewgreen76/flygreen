int loops;
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
    Pthread_mutex_lock(&mutex); // p1
    
    while (full == 1) // p2 // rechecking in the race 
      Pthread_cond_wait(&cond, &mutex); // p3
    
    put(i); // p4 // MUST BE EMPTY 
    Pthread_cond_signal(&cond); // p5
    Pthread_mutex_unlock(&mutex); // p6
  }
}

void *consumer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex); // c1
    
    while (full == 0) // c2 // rechecking in the race  
      Pthread_cond_wait(&cond, &mutex); // c3
    
    int tmp = get(); // c4 // MUST BE FULL 
    Pthread_cond_signal(&cond); // c5
    Pthread_mutex_unlock(&mutex); // c6
    printf("%d\n", tmp);
  }
}
