#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h> 
#include <assert.h>
#include <dirent.h>

int main(int argc, char *argv[]) {
  
  DIR *dp = opendir(".");
  assert(dp != NULL);
  
  struct dirent *d;
   
  while ((d = readdir(dp)) != NULL) {
    printf("%lu %s\n", (unsigned long) d->d_ino,
           d->d_name);
  }
   
  closedir(dp);
  return 0;
}
