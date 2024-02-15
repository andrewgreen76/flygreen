#include <unistd.h> // for read() , STDIN_FILENO 
#include <stdio.h>

int main() {
    char buffer[101];  // 100 characters + null terminator

                             // src_fd = 0, dest, bytes 
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

/* 
   . a read() attempt beyond the file’s end returns 0 , letting the process know that it has read the entire file. 
   . read() returns the number of bytes read (3rd arg) 
   . a read() should read past EOF to let the process know that it reached EOF 
*/
