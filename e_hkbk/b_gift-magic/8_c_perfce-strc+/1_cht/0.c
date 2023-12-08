#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc , char ** argv){
  FILE * f = fopen("z.txt","r");
  int code = -999999, n;
  printf("\n");

  /*
  while( fscanf(f , "%d" , &n) != EOF ){
    printf("n : %d\n", n);
  }
  */
  
  
  do{
    code = fscanf(f , "%d" , &n);
    printf("code : %d\n", code);
  }
  while( code != EOF );
  

  
  printf("\n");
  fclose(f);
}
