#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <string.h>

int main(int argc, char *argv[]) {
    // creates file
    int file = open("/tmp/file", O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);  
    char buffer[40];
    sprintf(buffer, "I am listening.\n");
    //writes data to file
    write(file, buffer, strlen(buffer));
    fsync(file);
    // closes the file
    close(file);  
    return 0;
}
