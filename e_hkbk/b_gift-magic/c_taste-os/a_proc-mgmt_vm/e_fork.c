#include <stdio.h>
#include <unistd.h>

int main(){
  int pcode = fork();
  if(pcode) printf("I am parent : %d\n", (int)getpid() );
  else printf("I am child : %d\n", (int)getpid() );
}
