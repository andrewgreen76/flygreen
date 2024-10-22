#include <unistd.h>
#include <stdio.h>


int getchar(){
  char c;
  return (read(0 , &c , 1) == 1) ? (unsigned char) c : EOF;
}


void main(){
  printf("Start\n");
  getchar();
  printf("End\n");
}
