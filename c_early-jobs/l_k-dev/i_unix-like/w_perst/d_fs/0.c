#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
    int dest_fd = open("example.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);

    // Redirect standard output to the file descriptor 'file'
    //    dup2(STDOUT_FILENO , file );
    dup2( dest_fd , STDOUT_FILENO );
    //    dup2(file, STDOUT_FILENO);
    // Now, anything written to STDOUT_FILENO will be directed to 'output.txt'
    printf("This goes to the file.\n");

    close(file);
    return 0;
}
