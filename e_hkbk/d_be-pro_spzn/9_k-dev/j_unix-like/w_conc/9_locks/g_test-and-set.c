typedef struct __lock_t {
    int flag;
} lock_t;


// Receive/set flag to state , return/test old flag state.
// . keeps checking on the flag from outside the function
// . updates the flag 
// . RETS 1 IF LOCK ACQUIRED 
//
//                    v flag to update                            // THREAD 1 :                // THREAD 2 : 
int crummy_test_and_set(int *cur_stt, 1) {                        //                (flag=0 , new=1)   
    int rprt_stt = *cur_stt; // 100 : 0 if I can finally pass     ->   100 : load ret flag(0)  ->    
    *cur_stt = 1;            // 101 : Let no one else pass.       ->   101 : flag <- 1         ->   100 : load ret flag(1) 
    return rprt_stt; 	     // 102 : Tell'em.                    ->   102 : RET 1 (ATOMIZE!!) ->   101 : flag <- 1 
}                                                                 //                           ->   102 : ret
//
//
//                                                                // THREAD 1 :                // THREAD 2 :
int atomic_test_and_set(int *cur_stt, 1) {                        //                (flag=0 , new=1)   
    int rprt_stt = *cur_stt; // 100 : 0 if I can finally pass     ->   100 : load ret flag(0)  ->    
    *cur_stt = 1;            // 101 : Let no one else pass.       ->   101 : flag <- 1         ->    
    return rprt_stt; 	     // 102 : Tell'em.                    ->   102 : ret 0             ->    
}                                                                 //   103 : (0)!=(1) => brk   ->   100 : load ret flag(1) 
                                                                  //                           ->   101 : flag <- 1
                                                                  //                           ->   102 : ret 1
                                                                  //                           ->   103 : (1)==(1) => spin
                                                                  //   xxx : flag <- 0         ->   xxx : (0)!=(1) => brk 
void init(lock_t *lock) {
    // 0: lock is available, 1: lock is held
    lock->flag = 0;
}

/* A spin-lock with a shared flag. */
void lock(lock_t *lock) {
    while (test_and_set(&lock->flag, 1) == 1)
    ; // spin-wait (do nothing)
}

void unlock(lock_t *lock) {
    lock->flag = 0;
}
