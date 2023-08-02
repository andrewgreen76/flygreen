#include <stdio.h>

int main(int argc, char * argv[])
{  
  printf("\nHello, world\n\n");

  int arr[2] = {4, 5};
  printf("arr[1] is: %i\n", arr[1]);


  
  char mstr[5];
  char * spy = mstr;
  printf("\nSlay this buffer: ");
  scanf("%s", mstr);
  //printf("You've printed: %s\n", mstr);
  //
  printf("I spy: %c\n", *spy);
  for(int i=0; i<100; i++)
  {
    spy++;
    printf("I spy: %c\n", *spy);
  }

  

  printf("\n");
  return 0;
}
