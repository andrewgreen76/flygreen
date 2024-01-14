#define MAX 10 
int buffer[MAX];
int fill = 0; // cur filled slot 
int use = 0;  // cur relieved slot
sem_t empty;
sem_t full;
/*
  0 <- empty's <- MAX
   . sem_wait(&empty);    // when no empty left , producers wait() 
  
  0 -> full's -> MAX 
   . sem_wait(&full);     // when no filled left , consumers wait() 


  Two comparisons to zero (emptied left and filled left) tied to two different wait()'s   <=   TWO SEMAPHORES 
  instead of one. 
*/

// =================== aux functions : ===================

void put(int value) {
  buffer[fill] = value; // Line F1
  fill = (fill + 1) % MAX; // Line F2    // LOOP OVER to start of buffer. 
}


int get() {
  int tmp = buffer[use]; // Line G1    // Scan thru w/ "use". 
  use = (use + 1) % MAX; // Line G2    // Roll over to start of buffer. 
  return tmp;
}

// =================== THREAD FUNCTIONS : ===================

void *producer(void *arg) {
  int i;
  for (i = 0; i < loops; i++) {    // populate the buffer 
    sem_wait(&empty); // Line P1
    put(i);           // Line P2   // marked filled , fills with iter val 
    sem_post(&full); // Line P3
  }
}


void *consumer(void *arg) {
  int tmp = 0;
  while (tmp != -1) {
    sem_wait(&full); // Line C1
    tmp = get();     // Line C2   // marked removed , rets buffer value 
    sem_post(&empty); // Line C3
    printf("%d\n", tmp);
  }
}


int main(int argc, char *argv[]) {
  // ...
  sem_init(&empty, 0, MAX); // MAX are empty
  sem_init(&full, 0, 0); // 0 are full
  // ...
}
