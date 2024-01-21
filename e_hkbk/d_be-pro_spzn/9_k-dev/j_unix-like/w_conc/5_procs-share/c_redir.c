#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int file_desc = open("output.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    dup2(file_desc, STDOUT_FILENO);

    printf("This will be written to output.txt\n");

    close(file_desc);
    return 0;
}
