#define MAX 10

cond_t empty, fill;
mutex_t mutex;
int count = 0 ;

// ==================== aux. functions : ====================

void put(int value) {
    assert(count < MAX);
    count++;
    buffer = value;
}


int get() {
    assert(count > 0);
    count--;    // mark as empty 
    return buffer;
}

// =================== THREAD FUNCTIONS : ===================

void *producer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex); // p1
    while (count == MAX) // p2
      Pthread_cond_wait(&empty, &mutex); // p3
    put(i); // p4
    Pthread_cond_signal(&fill); // p5
    Pthread_mutex_unlock(&mutex); // p6
  }
}

void *consumer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex); // c1
    while (count == 0) // c2
      Pthread_cond_wait(&fill, &mutex); // c3
    int tmp = get(); // c4
    Pthread_cond_signal(&empty); // c5
    Pthread_mutex_unlock(&mutex); // c6
    printf("%d\n", tmp);
  }
}
