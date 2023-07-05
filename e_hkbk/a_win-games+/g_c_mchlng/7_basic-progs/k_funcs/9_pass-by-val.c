#include <stdio.h>

void doStuff(char (* )[]);

int main(){
  char str[] = "Right!!\n";
  printf("\n");

  for(int t = 0; t < 3; t++)
    doStuff(&str);
  
  printf("\n");
  return 0;
}



void doStuff(char (* str_here)[]){
  printf("I want to learn C!\n");
  printf("I want to learn Assembly!\n");
  printf("I want to learn Python!\n");
  printf("I want to learn C++!\n");
  printf("Ah-well-uh-everybody's talking ... about the bird\nB-b-b-bird-bird-bird ... \n");
  printf("Right?!\n");
  
  printf("%s\n", *str_here);
    
  return;
}
