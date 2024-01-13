cond_t ps_slp, cs_slp;
mutex_t mutex;
int full = 0;

void *producer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex);
    while (full == 1)
      Pthread_cond_wait(&ps_slp, &mutex);
    put(i);
    Pthread_cond_signal(&cs_slp);
    Pthread_mutex_unlock(&mutex);
  }
}

void *consumer(void *arg) {
  int i;
  
  for (i = 0; i < loops; i++) {
    Pthread_mutex_lock(&mutex);
    while (full == 0)
      Pthread_cond_wait(&cs_slp, &mutex);
    int tmp = get();
    Pthread_cond_signal(&ps_slp);
    Pthread_mutex_unlock(&mutex);
    printf("%d\n", tmp);
  }
}
