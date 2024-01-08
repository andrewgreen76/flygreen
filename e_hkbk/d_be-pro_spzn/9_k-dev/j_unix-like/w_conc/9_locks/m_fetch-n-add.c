/* 
Fetch-And-Add :
 . ATOMIC ticketing mechanism 
   |
   . shared TICKET counter : used to ASSIGN TURN NUMBERS to threads 
   . shared TURN indicator : "YOU GO!" 
   . lock() : 
     . local_var ("MYTURN") STORES THE THREAD'S TURN NUMBER 
     . thread is trapped in a loop until it's the thread's turn 
   |
   => FIFO access to crit.sect
   => every thread gets a tap on the shoulder (once the thread in front of it is done)
      => no chance of infinite spinning 
*/

typedef struct __lock_t {
  int ticket;
  int turn;
} lock_t;

// Increment to new_ticket_no. , return old_ticket_no.
int fetch_and_add(int *ptr) {
  int old = *ptr;
  *ptr = old + 1;
  return old;
}

void lock_init(lock_t *lock) {
  lock->ticket = 0;
  lock->turn = 0;
}

// =====================================================================================
void lock(lock_t *lock) {
  int myturn = fetch_and_add(&lock->ticket);
  while (lock->turn != myturn) ; // spin
} // The "myturn" variable here is local to the lock() of the thread.
  // The lock and its members are shared , however. 
// =====================================================================================

void unlock(lock_t *lock) {
  lock->turn = lock->turn + 1;
}

/*               | T1                 | T2                  | 
-----------------+--------------------+---------------------+
  tkt=0 , turn=0 | load ret tkt(0)    |                     | 
                 | tkt <- 1           |                     | 
                 | ret 0              |                     | 
                 | myturn <- 0        | load ret tkt(1)     | 
                 | t(0)==mt(0) => brk | tkt <- 2            | 
                 | ...                | ret 1               | 
                 |                    | myturn <- 1         | 
                 |                    | t(0)!=mt(1) => loop | 
                 | turn <- 1          | t(0)==mt(0) => brk  | 
                 |                    | ...                 | 
                 |                    | turn <- 2           | 
                 |                    |                     |
=====================================================================================
Works like a queue , but tickets and turns are stored as integers , not nodes. 
=====================================================================================
                 | T1                 | T2                  | T3                  |
-----------------+--------------------+---------------------+---------------------+
  tkt=0 , turn=0 | load ret tkt(0)    |                     |                     |
                 | tkt <- 1           |                     |                     | 
                 | ret 0              |                     |                     |
                 | myturn <- 0        | load ret tkt(1)     |                     |
                 | t(0)==mt(0) => brk | tkt <- 2            |                     |
                 |                    | ret 1               |                     |
                 |                    | myturn <- 1         | load ret tkt(2)     |
                 |                    | t(0)!=mt(1) => loop | tkt <- 3            |
                 |                    |                     | ret 2               |
                 |                    |                     | myturn <- 2         |
                 |                    |                     | t(0)!=mt(2) => loop |
                 |                    |                     |                     |
                 |                    |                     |                     |
                 |                    |                     |                     |
                 |                    |                     |                     |
*/
