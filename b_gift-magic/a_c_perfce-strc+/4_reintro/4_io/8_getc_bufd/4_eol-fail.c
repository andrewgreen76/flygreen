#include <stdio.h>

void main(){
  printf("Print : ");
  char ch = 'U';
    
  while(ch != '\0'){
    getc(stdin);
  }
  
  printf("Output : %c\n" , ch);
}
