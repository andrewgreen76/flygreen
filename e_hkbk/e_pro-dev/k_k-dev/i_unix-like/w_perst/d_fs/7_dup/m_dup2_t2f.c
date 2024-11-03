#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
    int dest_fd = open("example.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);

    // Redirect standard output to the file descriptor 'file'
    dup2( dest_fd , STDOUT_FILENO );
    printf("This goes to the file.\n");

    close(dest_fd);
    return 0;
}
