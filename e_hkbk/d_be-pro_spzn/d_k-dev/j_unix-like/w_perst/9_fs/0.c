#include <unistd.h> // for read() , STDIN_FILENO 
#include <stdio.h>

int main() {
    char buffer[101];  // 100 characters + null terminator

    // Read from standard input (file descriptor 0)
    ssize_t bytesRead = read(STDIN_FILENO, buffer, 100);

    if (bytesRead == -1) {
        perror("read");
        return 1;  // Error
    }

    // Null-terminate the buffer to treat it as a string
    buffer[bytesRead] = '\0';

    // Print the content read from standard input
    printf("Read from standard input: %s\n", buffer);

    return 0;
}
