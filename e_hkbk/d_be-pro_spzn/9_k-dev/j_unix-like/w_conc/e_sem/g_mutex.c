/*
  . producers (empty -> -1 , full -> MAX) take their joint turn over the buffer 
  . consumers (full -> -1 , empty -> MAX) take their joint turn over the buffer 
  . producers can still step on each others' toes ; same goes for consumers 
  => need a mutex for that 

*/

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
  for (i = 0; i < loops; i++) {
    sem_wait(&mutex); // Line C0 (NEW LINE)
    sem_wait(&full); // Line C1
    int tmp = get(); // Line C2
    sem_post(&empty); // Line C3
    sem_post(&mutex); // Line C4 (NEW LINE)
    printf("%d\n", tmp);
  }
}
