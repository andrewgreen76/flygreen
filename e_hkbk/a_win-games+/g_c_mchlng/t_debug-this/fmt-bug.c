#include <stdio.h>

int main(int argc, char **argv)
{
  int d = 2;

  printf("\nWelcome to a program with a bug!\n");
  scanf("%d", d);
  printf("You gave me: %d\n", d);

  return 0;
}
