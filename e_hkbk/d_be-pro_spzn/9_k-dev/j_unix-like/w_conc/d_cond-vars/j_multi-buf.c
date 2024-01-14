#define MAX 10 

cond_t empty, // sound off to prod's - buffer is empty 
       full;  // sound off to cons's - buffer is full
mutex_t mutex;

int buffer[MAX];
int fill_ptr = 0;
int use_ptr = 0;
int count = 0;

// =================== aux. functions : ===================

void put(int value) {
  buffer[fill_ptr] = value; 
  fill_ptr = (fill_ptr + 1) % MAX; // head to tail -> roll over to 0 -> done 
  count++;
}


int get() {
  int tmp = buffer[use_ptr];
  use_ptr = (use_ptr + 1) % MAX; // also head to tail -> roll over to 0 -> done  
  count--;
  return tmp;
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
