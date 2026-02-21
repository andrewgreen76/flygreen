#include <stdio.h>
#include <string.h>

#define BUFSZ_TOTAL 6
#define BUFSZ_TIGHT BUFSZ_TOTAL-1

void main(){
  printf("Total : %d\n" , BUFSZ_TOTAL);
  printf("Tight : %d\n" , BUFSZ_TIGHT);
  char buf[BUFSZ_TOTAL];
  
  fgets(buf , BUFSZ_TOTAL , stdin);

  if( strcmp(buf,"1")==0 ) printf("1");
  if( strcmp(buf,"1\0")==0 ) printf("1\\0"); 
  if( strcmp(buf,"1\n")==0 ) printf("1\\n"); // This is the one upon 'Enter' press. 
}
