/*  */

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define CHBUF_SIZE 4

/* GLOBAL ALLOCATION OF STRING */
char * fn = "1_victim.c";

int main(){
  printf("\n");

  /* EXPLORING VARIABLE ALLOCATION IN MEMORY */
  int v = 1;
  int * addr = &v;
  printf("v: %d\n" , v);
  printf("addr: %lx\n" , (unsigned long)addr );
  printf("\n");

  // =========================== Open the file for reading  =========================== 
  int fd = open(fn, O_RDONLY);
  if (fd == -1) {
    perror("Cannot open file\n");
    return 1; // Return error if unable to open the file
  }

  // Read data from the file (example: read and print 100 bytes)
  char buffer[CHBUF_SIZE]; // Buffer to store the read data (plus 1 for null terminator)
  ssize_t bytes_read = read(fd, buffer, CHBUF_SIZE-1); // 1 - number of text chars ; +1 (\0) = 2. 
  if (bytes_read == -1) {
    perror("read");
    close(fd); // Close the file before exiting in case of error
    return 1; // Return error
  }
  buffer[bytes_read] = '\0';
  printf("===================================================\n%s\n===================================================\n", buffer);

  // ================================= Close the file ================================== 
  if (close(fd) == -1) {
    perror("Cannot close file\n");
    return 1; // Return error if unable to close the file
  }
  // =================================================================================== 
    
  printf("\n");
}
