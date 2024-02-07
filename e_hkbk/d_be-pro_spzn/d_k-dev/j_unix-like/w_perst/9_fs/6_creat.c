#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>  // Include this for O_CREATE, etc.

int main()
{
  int fd = open("aFile", O_CREAT | O_WRONLY | O_TRUNC,  S_IRUSR | S_IWUSR);
  
  printf("The file descriptor of the file is: %d\n", fd);
  return 0;
}

