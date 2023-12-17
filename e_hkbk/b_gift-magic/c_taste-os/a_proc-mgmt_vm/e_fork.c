#include <stdio.h>
#include <unistd.h>

int main(){
  int child_code = fork();
  
  if(child_code < 0) printf("Failed to create a child process\n");
  else {
    printf("(%d) ", (int)getpid() );
    printf("Generated child_code : %d\n", child_code);
  }
}
