#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int pipe_fd[2];
    char buffer[50];

    if (pipe(pipe_fd) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    if (fork() == 0) { // Child process
        close(pipe_fd[1]); // Close write end
        read(pipe_fd[0], buffer, sizeof(buffer));
        printf("Child received: %s\n", buffer);
        close(pipe_fd[0]);
    } else { // Parent process
        close(pipe_fd[0]); // Close read end
        write(pipe_fd[1], "Hello, child!", 13);
        close(pipe_fd[1]);
    }

    return 0;
}
