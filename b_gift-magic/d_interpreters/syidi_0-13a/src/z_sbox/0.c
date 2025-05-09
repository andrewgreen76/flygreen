#include <stdio.h>
#include <stdlib.h>
//#include <string.h>

int main(){
  unsigned char * dynbuf;
  short int dbsize = 2;
  short int dbi = 0;
  unsigned char kc = 0;

  while( ! (dynbuf=malloc(dbsize)) );

  ////////////////////////////////////////
  while(1){
    read(STDIN_FILENO , &kc , 1);
    if(kc==4) break;
    dynbuf[dbi] = kc;
    dynbuf[dbi+1] = '\0';

    printf("%s" , dynbuf);
    dynbuf=realloc( dynbuf , dbsize+1 );
    dbi++;
  }
  ////////////////////////////////////////

  free(text);
  return 0;
}
