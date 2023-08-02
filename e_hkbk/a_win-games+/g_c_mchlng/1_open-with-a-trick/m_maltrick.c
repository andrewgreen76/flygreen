#include <stdio.h>

int main(int argc, char * argv[])
{  
  printf("\nHello, world\n\n");

  int arr[2] = {4, 5};
  printf("arr[1] is: %i\n", arr[1]);

  char mstr[5];
  printf("\nSlay this buffer: ");
  scanf("%s", mstr);
  printf("\nYou've printed: %s\n", mstr);

  printf("\n");
  return 0;
}
