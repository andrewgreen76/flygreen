#include <stdio.h>

void main(){
  printf("Print : ");
  char ch = 'U';
  
  while(ch != '\n'){
    getc(stdin);
  }

  printf("Output : %c\n" , ch);
}
