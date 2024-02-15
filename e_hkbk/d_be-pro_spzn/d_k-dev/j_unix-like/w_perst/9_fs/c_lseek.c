#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int main() {
    int fd = open("example.txt", O_RDONLY);

    if (fd == -1) {
        perror("open");
        return 1;
    }

    //off_t offset = lseek(fd, 0, SEEK_END); // Move to the end of the file

    if (offset == (off_t)-1) {
        perror("lseek");
        close(fd);
        return 1;
    }

    //printf("Size of the file: %lld bytes\n", (long long)offset);

    close(fd);
    return 0;
}
