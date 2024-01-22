#include <stdio.h>
#include <stdlib.h>
#include <sys/shm.h>

int main() {
    key_t key = ftok("/tmp", 'A');
    int shmid = shmget(key, 1024, IPC_CREAT | 0666);
    char* shared_memory = (char*)shmat(shmid, NULL, 0);

    sprintf(shared_memory, "Hello, shared memory!");

    shmdt(shared_memory);
    shmctl(shmid, IPC_RMID, NULL);

    return 0;
}
