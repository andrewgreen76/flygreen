
// Counter with lock. Now we can round up threads (typically as FIFO) and tell them when to go. 

typedef struct __counter_t {
   int value;
   pthread_mutex_t lock;
} counter_t;


void init(counter_t *c) {
   c->value = 0;
   Pthread_mutex_init(&c->lock, NULL);
}


void increment(counter_t *c) {
   Pthread_mutex_lock(&c->lock);
   c->value++;
   Pthread_mutex_unlock(&c->lock);
}


void decrement(counter_t *c) {
   Pthread_mutex_lock(&c->lock);
   c->value--;
   Pthread_mutex_unlock(&c->lock);
}


int get(counter_t *c) {
   Pthread_mutex_lock(&c->lock);
   int rc = c->value;
   Pthread_mutex_unlock(&c->lock);
   return rc;
}
