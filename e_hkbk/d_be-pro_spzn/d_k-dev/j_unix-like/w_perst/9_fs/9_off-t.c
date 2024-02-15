#include <stdio.h>
#include <unistd.h> // lseek() , close() // <- <sys/types.h> // <- off_t 
#include <fcntl.h> // open() , O_RDONLY // <- <sys/types.h> // <- off_t 

int main() {
    int fd = open("example.txt", O_RDONLY);

    if (fd == -1) {
        perror("open");
        return 1;
    }

    off_t offset = lseek(fd, 0, SEEK_END); // Move to the end of the file

    if (offset == (off_t)-1) {
        perror("lseek");
        close(fd);
        return 1;
    }

    printf("Size of the file: %lld bytes\n", (long long)offset);
    printf("sizeof(off_t): %ld\n", sizeof(off_t) );

    close(fd);
    return 0;
}
