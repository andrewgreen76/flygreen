
// A very common solution in multi-threaded programs. 

void *producer(void *arg) {
  int i;
  for (i = 0; i < loops; i++) {
    sem_wait(&empty); // Line P1
    sem_wait(&mutex); // Line P1.5 (MUTEX HERE)
    put(i); // Line P2    // atomic placement 
    sem_post(&mutex); // Line P2.5 (AND HERE)
    sem_post(&full); // Line P3
  }
}



void *consumer(void *arg) {
  int i;
  for (i = 0; i < loops; i++) {
    sem_wait(&full); // Line C1    // wait on the producers to step in 
    sem_wait(&mutex); // Line C1.5 (MUTEX HERE)
    int tmp = get(); // Line C2    // atomic removal/ret 
    sem_post(&mutex); // Line C2.5 (AND HERE)
    sem_post(&empty); // Line C3
    printf("%d\n", tmp);
  }
}
