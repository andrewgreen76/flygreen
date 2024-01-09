/*
  This is similar to the fetch-and-add FIFO affair. 
   |
   . (*mutex)[31]    = lock state 
   . (*mutex)[30..0] = ticket counter 
   .        v        = thread's turn number 
*/

void mutex_lock (int *mutex) {
    int v;

    // =================================== FAST PATH (optimized for 1st caller)  ====================================
    if (atomic_bit_test_set (mutex, 31) == 0)    // Bit 31 was clear => mutex is avail. => ACQ the mutex (the fast path). 
      return;                                    // -> get out -> move on to crit.sect. 
                                                 // 
                                                 // mutex_sign == 1    => contention
    
    // ============================== Kernel space / handling CONTENTION (SLOW PATH) : ==============================
    atomic_increment (mutex);   // *mutex tracks contending threads. 
    
    while (1) {                 // Test-and-set mutex bit 31 for lock state again. 
	if (atomic_bit_test_set (mutex, 31) == 0) {
	    atomic_decrement (mutex);
	    return;
	}
	// STILL TAKEN. 

	v = *mutex;            // (re)assign turn number 
	
	if (v >= 0)            // v>=0 (lock is free) -> unlist , bounce , do crit_sect 
	  continue;            // v<0 (lock is acqd) -> move on to sleep 
	
	futex_wait (mutex, v); // lock is acqd -> mutex not changed            => spin for lock NOW    (spin-not-wait optimization)    // slower path    
	                       // lock is acqd -> mutex changed (more threads) => enq, wait till unlocked                              // slowest path 
    }                          
}                              



void mutex_unlock (int *mutex) {
    /* Adding 0x80000000 to counter results in 0 if and only if there are not other interested threads */
    if (atomic_add_zero (mutex, 0x80000000))  // 1 + 1 = <1>| 0    // 0x1??????? + 0x1??????? = 0x0??????? 
        return;                               // If lock is free -AND- no threads waiting. 

    futex_wake (mutex);    // Lock is made free , but there are threads waiting. 
}

/*
  T    mutex    v
---------------------
  0 - - - - - - - - 
  1      1      1 
  2      2      2   
  3      3      3  
  
*/
