// how many bytes of the heap are free?
#define MAX_HEAP_SIZE 100 
int bytesLeft = MAX_HEAP_SIZE; // available byte count 

// need lock and condition too
cond_t c;
mutex_t m;



void * allocate(int size) {
  Pthread_mutex_lock(&m);
  
  while (bytesLeft < size)
    Pthread_cond_wait(&c, &m);
  void *ptr = ...; // get mem from heap (hypothetical free mmgmt routine) 
  bytesLeft -= size; // decrease available byte count 
  
  Pthread_mutex_unlock(&m);
  return ptr;
}

void free(void *ptr, int size) {
  Pthread_mutex_lock(&m);
  
  bytesLeft += size; // increase available byte count 
  Pthread_cond_signal(&c); // whom to signal??
  
  Pthread_mutex_unlock(&m);
}
