#include <stdio.h>

int main(){
  char familyName[50];
  char firstName[50];
  int age; 
  printf("What is your family name?");
  scanf("%s", familyName);
  printf("What is your first name?");
  scanf("%s", firstName);
  printf("What is your age?");
  scanf("%d", &age);
  printf("%s %s %d\n", familyName,firstName,age);
  return 0;
}
