/*
  . producers (empty -> -1 , full -> MAX) take their joint turn over the buffer 
  . consumers (full -> -1 , empty -> MAX) take their joint turn over the buffer 
  . producers can still step on each others' toes ; same goes for consumers 
  => we can add a mutex for that 
  => may result in a deadlock (threads waiting on one another) 

*/
// ==========================================================================================

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

// ==========================================================================================

void *producer(void *arg) {
  int i;
  for (i = 0; i < loops; i++) {
    sem_wait(&mutex); // Line P0 (NEW LINE)   
    sem_wait(&empty); // Line P1
    put(i); // Line P2                         
    sem_post(&full); // Line P3
    sem_post(&mutex); // Line P4 (NEW LINE)
  }
}


void *consumer(void *arg) {
  int i;
  for (i = 0; i < loops; i++) {               // CONSUMERS CAN START FIRST. 
    sem_wait(&mutex); // Line C0 (NEW LINE)   // acquires the lock 
    sem_wait(&full); // Line C1               // full : (0 -> -1) -> "sleeps" , keeps the mutex => no producer can post 
    int tmp = get(); // Line C2                
    sem_post(&empty); // Line C3
    sem_post(&mutex); // Line C4 (NEW LINE)
    printf("%d\n", tmp);
  }
}

