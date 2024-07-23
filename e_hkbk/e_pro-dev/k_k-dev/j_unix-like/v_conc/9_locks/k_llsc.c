// Load-linked (LL) and store-conditional (SC) :
// . more refined CAS
// . ATOMIC
// . used in MIPS ISA 
// . sometimes used in ARM and PowerPC ISAs 

// ===========================================================================
// =============== PSEUDOCODE : load-linked , store-conditional ===============
// ===========================================================================

// Periodically checks whether the lock is still acquired. The thread waits.
// . rets 1 if LOCK WAS ACQUIRED. 
int LoadLinked(int *ptr) {
  return *ptr;
}

// Once the lock is free :
// . If the lock is still free , raise the flag to acquire the lock.
// . rets 1 if SUCCESS AT ACQUISITION.  
int StoreConditional(int *ptr, int value) {
  if ( *ptr==0 ) {
    *ptr = value;
    return 1; // success!
  } else {
    return 0; // failed to update ; another thread already acquired the lock. 
}

// ===========================================================================
// ===================== PSEUDOCODE : locking functions ======================
// ===========================================================================

void lock(lock_t *lock) {
  while (1) {
    while (LoadLinked(&lock->flag) == 1)
    ; // spin until it’s zero
    if (StoreConditional(&lock->flag, 1) == 1)
      return; // If this thread raised the flag, it acquires lock, goes thru. 
              // If failed to raise the flag first, back to spinning. 
  }
}
// ===========================================================================
// if LOCK HAS BEEN ACQUIRED --OR-- FAILED TO RAISE THE FLAG FIRST : 
void lock(lock_t *lock) {
  while (LoadLinked(&lock->flag) ||
	 !StoreConditional(&lock->flag, 1))
  ; // spin
}

// ===========================================================================
// =========================== PSEUDOCODE : unlock()  ========================
// ===========================================================================

 void unlock(lock_t *lock) {
  lock->flag = 0;
}
