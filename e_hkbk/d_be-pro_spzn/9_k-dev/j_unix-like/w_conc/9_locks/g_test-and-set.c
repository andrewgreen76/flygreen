typedef struct __lock_t {
    int flag;
} lock_t;


// Receive/set new value , return/test old value. 
//
//                    v flag to update                            // THREAD 1 :                // THREAD 2 : 
int nonatomic_TestAndSet(int *old_ptr, int new) {                 //                (flag=0 , new=1)   
    int old = *old_ptr; // 100 : fetch old value at old_ptr       ->   100 : load ret flag<>0  ->    
    *old_ptr = new;     // 101 : store ’new’ into old_ptr         ->   101 : flag <- 1         ->   100 : load ret flag<>1 
    return old; 	// 102 : return the old value             ->   102 : RET 1 (ATOMIZE!!) ->   101 : flag <- 1 
}                       //                                                                     ->   102 : ret
//
//
//                                                                // THREAD 1 :                // THREAD 2 :
int atomic_TestAndSet(int *old_ptr, int new) {                    //                (flag=0 , new=1)   
    int old = *old_ptr; // 100 : fetch old value at old_ptr       ->   100 : load ret flag<>0  ->    
    *old_ptr = new;     // 101 : store ’new’ into old_ptr         ->   101 : flag <- 1         ->    
    return old; 	// 102 : return the old value             ->   102 : ret 0             ->    
}                                                                 //                           ->   100 : load ret flag<>1
                                                                  //                           ->   101 : flag <- 1
                                                                  //                           ->   102 : ret 1
void init(lock_t *lock) {
    // 0: lock is available, 1: lock is held
    lock->flag = 0;
}

/* A spin-lock with a shared flag. */
void lock(lock_t *lock) {
    while (TestAndSet(&lock->flag, 1) == 1)
    ; // spin-wait (do nothing)
}

void unlock(lock_t *lock) {
    lock->flag = 0;
}
