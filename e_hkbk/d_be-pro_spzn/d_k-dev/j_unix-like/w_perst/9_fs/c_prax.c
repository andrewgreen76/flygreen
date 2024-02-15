#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int main() {
    int fd = open("example.txt", O_RDONLY);
    
    if (fd == -1) {
        perror("open");
        return 1;
    }

    off_t offset = 0;
    char c;

    for (int i=0 ; i<6 ; i++) read(3, &c, 1); // middle of the file 
    printf("char : %c\n", c );
    
    offset = lseek(fd, 0, SEEK_SET); // start of file 
    read(3, &c, 1);
    printf("char : %c\n", c );
    
    offset = lseek(fd, -2, SEEK_END); // last char , before EOF 
    read(3, &c, 1);
    printf("char : %c\n", c );
    
    offset = lseek(fd, -3, SEEK_CUR); // stay where you are , move over 
    read(3, &c, 1);
    printf("char : %c\n", c );
    
    /*
    if (offset == (off_t)-1) {
        perror("lseek");
        close(fd);
        return 1;
    }
    */

    close(fd);
    return 0;
}
