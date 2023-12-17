#include <stdio.h>
#include <unistd.h>

int main(){
  int pcode = fork();
  
  if(pcode<0) printf("Failed to create a child process\n");
  else if(pcode==0) printf("I am child process : %d\n", (int)getpid() );
  else printf("I am parent process : %d\n", (int)getpid() );
}
