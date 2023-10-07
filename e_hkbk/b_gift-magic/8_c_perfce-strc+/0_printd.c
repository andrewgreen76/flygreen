#include <stdio.h>

void printd(int n) {
  if (n < 0) {
    putchar('-');
    n = -n;
  }

  if (n / 10)
    printd(n / 10);
  putchar(n % 10 + '0');
  
  return;
}

int main(int argc, char *argv[]) {
  printf("\n");

  printd(123);

  printf("\n");
  return 0;
}
