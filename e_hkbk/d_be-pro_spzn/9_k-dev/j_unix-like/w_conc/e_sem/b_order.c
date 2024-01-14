sem_t s;

/*
  sem_init(&s, 0, 1);    // semval = 1 if 1st thread is peer thread 
   . "will act as a lock"

  sem_init(&s, 0, 0);    // semval = 0 if 1st thread is parent thread 
   . "will act as an ordering mechanism" 

  This is easy to deal with when working only with a couple of threads. 

 */

void *child(void *arg) {
  printf("child\n");
  sem_post(&s); // signal here: child is done
  return NULL;
}


int main(int argc, char *argv[]) {
  sem_init(&s, 0, X); // what should X be?
  printf("parent: begin\n");
  pthread_t c;
  Pthread_create(&c, NULL, child, NULL);
  sem_wait(&s); // wait here for child
  printf("parent: end\n");
  return 0;
}
