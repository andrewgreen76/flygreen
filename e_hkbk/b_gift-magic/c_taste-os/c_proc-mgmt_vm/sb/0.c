#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int
main(int argc, char *argv[])
{
    printf("Starting the program... (pid:%d)\n", (int) getpid());
    int child = fork();
    if (child < 0) {
        // child process failed, exit the program
        fprintf(stderr, "Child process was not created\n");
        exit(1);
    } else if (child != 0) {
        // parent process runs this branch
        int waiting = wait(NULL);
        printf("Hello from the parent process (waiting:%d) (pid:%d)\n",
               waiting, (int) getpid());
    } else if (child == 0) {
        // child process created successfully
        printf("Hello from the child process (pid:%d)\n", (int) getpid());
        sleep(5);
    } 
    
    return 0;
}
