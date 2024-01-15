typedef struct __Zem_t {
  int value;
  pthread_cond_t cond;
  pthread_mutex_t lock;
} Zem_t;


// only one thread can call this (one semaphore/init for all threads) 
void Zem_init(Zem_t *s, int value) {
  s->value = value;
  Cond_init(&s->cond);
  Mutex_init(&s->lock);
}


// alternative sem_wait() - wait-then-decr 
void Zem_wait(Zem_t *s) {
  Mutex_lock(&s->lock);
  while (s->value <= 0)
    Cond_wait(&s->cond, &s->lock);
  s->value--;   // 1st thread skips
                // sem-val will never be negative 
  Mutex_unlock(&s->lock);
}
// ... vs. decr-then-wait
/*
  This looks like a true binary semaphore : 
   . 1 - free 
   . 0 - acquired (whether or not there is another thread coming through) 
     . T_x is done -> raises sem-val 
     -> sounds off to a waiting thread T_y 
     -> awoken thread lowers sem-val immediately 
     -> ... crit_sect ... 
*/


void Zem_post(Zem_t *s) {
  Mutex_lock(&s->lock);
  s->value++;            // Tn raises sem-val 
  Cond_signal(&s->cond); // -> sounds off to a waiting thread 
  Mutex_unlock(&s->lock);
}

/*
  s    P    C

  5    //   // 
*/
