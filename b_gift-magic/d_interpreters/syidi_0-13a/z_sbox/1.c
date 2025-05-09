#include <stdio.h>

int main(int argc , char * argv[]) {

  printf("In 1.c : argc : %d\n" , argc);
  
  for( int a=0 ; a!=argc ; a++ ){
    printf("In 1.c : %s\n" , argv[a]);
  }
  return 0;
}
