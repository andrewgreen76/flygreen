// Fast path (user space)
if (atomic_read(&futex) == 0) {
    // No contention, acquire lock
    atomic_write(&futex, 1);
}
else {
    // Contention, transition to slow path (kernel space)
    futex_wait(&futex, 0);  // System call: FUTEX_WAIT
}
