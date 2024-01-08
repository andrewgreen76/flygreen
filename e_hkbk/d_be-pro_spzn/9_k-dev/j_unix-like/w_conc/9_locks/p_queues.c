/*
  We need a queue to log waiting threads. 
  . queue_add(q , gettid())   // for getting the thread and waking it up, then put it to sleep()  
  . park() = sleep()          // park() puts this thread to sleep 
  . unpark(tid) = wake the thread up 
*/

typedef struct __lock_t {
    int flag;
    int guard;
    queue_t *q;
} lock_t;


void lock_init(lock_t *m) {
    m->flag = 0;
    m->guard = 0;
    queue_init(m->q); // queue of threads 
}


void lock(lock_t *m) {
    while ( test_and_set(&m->guard, 1) == 1 )
    ; //acquire guard lock by spinning
    
    if (m->flag == 0) {
	m->flag = 1; // lock is acquired
	m->guard = 0;
    }
    else {
      queue_add(m->q, gettid()); // add thread to queue 
	m->guard = 0;
	park();
    }
}


void unlock(lock_t *m) {
    while ( test_and_set(&m->guard, 1) == 1 )
    ; //acquire guard lock by spinning
    
    if (queue_empty(m->q))
        m->flag = 0; // let go of lock; no one wants it
    else
        unpark(queue_remove(m->q)); // rmv thread from head of queue ; hold lock
    // (for next thread!)
    m->guard = 0;
}
