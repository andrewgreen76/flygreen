#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int ofd = open("example.txt", O_RDONLY);

    // Duplicate the file descriptor
    int nfd = dup(ofd);

    ///////////////////////////////////////////////
    off_t offset = 0;
    char c;

    read(ofd, &c, 1); 
    printf("char : %c\n", c );
    read(nfd, &c, 1); 
    printf("char : %c\n", c );
    read(ofd, &c, 1); 
    printf("char : %c\n", c );
    read(nfd, &c, 1); 
    printf("char : %c\n", c );
    ///////////////////////////////////////////////
    close(ofd);
    close(nfd);

    return 0;
}
