/*
  We need a queue to log waiting threads. 
  . queue_add(q , gettid())   // for getting the thread and waking it up, then put it to sleep()  
  . park() = sleep()          // park() puts this thread to sleep 
  . unpark(tid) = wake the thread up
  |
  |
  . m->guard = acq ; causes thread to spin 
  . m->flag  = any-sleeping flag 
  |
  |
  We need to be convinced that this will improve lock efficiency and prevent starvation. 
*/

typedef struct __lock_t {
    int flag;
    int guard;
    queue_t *q;
} lock_t;


int atomic_test_and_set(int *cur_stt, 1) { 
    int rprt_stt = *cur_stt; 
    *cur_stt = 1; 
    return rprt_stt; 
}  


void lock_init(lock_t *m) {
    m->flag = 0;
    m->guard = 0;
    queue_init(m->q); // queue of threads 
}


void lock(lock_t *m) {                                        // Thread 1            | Thread 2            | flag <- 0 ; guard <- 0 
    while ( test_and_set(&m->guard, 1) == 1 )                 //---------------------+---------------------+
    ; //acquire guard lock by spinning                        // load ret guard(0)   |                     | <
                                                              // guard <- 1          |                     | < ATOMIC MOMENT
    if (m->flag == 0) {                                       // ret 0               |                     | <_______________
	m->flag = 1; // lock is acquired                      //                     | load ret guard(1)   | < 
	m->guard = 0;                                         //                     | guard <- 1          | < ATOMIC MOMENT
    }                                                         //                     | ret 1               | < 
    else {                                                    // (0)!=1 => brk       |  (1)==1 => spin     |
	queue_add(m->q, gettid()); // add thread to queue     //  flag(0)==0         |  (1)==1 => spin     |
	m->guard = 0;                                         //  flag <- 1          |  (1)==1 => spin     |
	park();                                               //  guard <- 0 /noelse/|  (0)!=1 => brk      |
    }                                                         // ... crit.sect ...   | flag(1)!=0          |
}                                                             //  load ret guard(0)  |                     | <
                                                              //  guard <- 1         |                     | < ATOMIC MOMENT 
                                                              //  ret 0              |                     | < 
                                                              // (0)!=1 => brk       | queue_add(tail->T2) |
                                                              //  q NOT empty        | guard <- 0          |
                                                              //  queue_rmv(head->T2)| sleep(T2)           |
                                                              //  wake_up(T2)        |  up , ..crit.sect.. |
                                                              // guard <- 0          |  .................. |
                                                              ///////////////////////| load ret guard(0)   | < 
                                                                                   //| guard <- 1          | < ATOMIC MOMENT 
                                                                                   //| ret 0               | < 
                                                                                   //|  q is EMPTY         |
                                                                                   //|  flag <- 0          |
void unlock(lock_t *m) {                                                           //| guard <- 0          |
    while ( test_and_set(&m->guard, 1) == 1 )                                      /////////////////////////
    ; //acquire guard lock by spinning
    
    if (queue_empty(m->q))
        m->flag = 0; // let go of lock; no one wants it
    else
        unpark(queue_remove(m->q)); // rmv thread from head of queue ; hold lock
    // (for next thread!)
    m->guard = 0;
}

//================================================================================
//================================================================================
//================================================================================

queue_add(m->q, gettid());
 setpark(); // new code
 m->guard = 0;
