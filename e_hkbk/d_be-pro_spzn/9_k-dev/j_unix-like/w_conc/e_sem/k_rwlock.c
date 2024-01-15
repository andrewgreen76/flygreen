/*
  rwlock : 
   . used on complex data structures (e.g., linked list) 
   . one write at a time 
   . NO WRITING WHILE STRUCT IS READ 
   . waiting writer => lack of fairness 
   => STARVING WRITER => keep more readers out (need new implementation) 
*/

typedef struct _rwlock_t {
  sem_t lock; // binary semaphore (basic lock)
  sem_t writelock; // ALLOW ONE WRITER / MANY READERS
  int readers; // num of readers in crit_sect 
} rwlock_t;

// ==========================================================
void rwlock_init(rwlock_t *rw) {
  rw->readers = 0;
  sem_init(&rw->lock, 0, 1);
  sem_init(&rw->writelock, 0, 1);
}
// ======================= READ : ===========================
void rwlock_acquire_readlock(rwlock_t *rw) {
  sem_wait(&rw->lock);
  rw->readers++;
  if (rw->readers == 1) // first reader gets writelock
    sem_wait(&rw->writelock); // last reader frees => NO WRITING WHILE STRUCT IS READ 
  sem_post(&rw->lock);
}

void rwlock_release_readlock(rwlock_t *rw) {
  sem_wait(&rw->lock);
  rw->readers--;
  if (rw->readers == 0) // last reader lets it go
    sem_post(&rw->writelock); // NO WRITING WHILE STRUCT IS READ 
  sem_post(&rw->lock);
}
// ================ straightforward write : =================

// acquires the binary writelock 
void rwlock_acquire_writelock(rwlock_t *rw) {
  sem_wait(&rw->writelock);
}

// releases the binary writelock 
void rwlock_release_writelock(rwlock_t *rw) {
  sem_post(&rw->writelock);
}
