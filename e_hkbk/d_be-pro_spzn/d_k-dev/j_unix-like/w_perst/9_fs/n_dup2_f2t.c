#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
    int src_fd = open("example.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);

    // Redirect standard output to the file descriptor 'file'
    dup2( STDOUT_FILENO , src_fd );

    char * buffer = "Hello\n";
    int bytes = write(src_fd, buffer, strlen(buffer));
    
    close(src_fd);
    return 0;
}
