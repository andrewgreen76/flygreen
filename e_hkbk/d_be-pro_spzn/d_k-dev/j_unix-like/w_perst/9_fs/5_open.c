#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>  // Include this for O_CREATE, etc.

int main()
{
  int fd = open("aFile", O_CREAT | O_WRONLY | O_TRUNC,  S_IRUSR | S_IWUSR);
  
  printf("The file descriptor of the file is: %d\n", fd);
  return 0;
}

/*
    O_CREAT - creates the file
    O_WRONLY - locks it,
    O_TRUNC - truncates it to zero bytes, erasing any existing content
    S_IRUSR|S_IWUSR - permissions are set to allow the owner to read and write to the file.
*/


/* 
   The same file can be opened for than once before a close. 
    . every open returns an independent file descriptor 
    => accessing a file in multiple locations 
    . one process ~ one open/fd ~ OFT (open file table) entry 
*/
