#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  printf("\n");

  int inlen;
  const int bufsize = 10;
  char buffer[bufsize];
  char * lastc = &(buffer[bufsize-1]);
  
  printf("Enter anything: ");
  inlen = strlen( fgets(buffer, bufsize, stdin) );
  
  printf("\nYou've entered: %s\n", buffer);
  printf("Length (incl. \\n): %d\n", inlen);
  printf("Buffer size: %d\n", bufsize);
  
  if(*lastc == '\0') printf("(1) End of string: \\0\n");
  else if(*lastc == '\n') printf("(2) End of string: \\n\n");
  else printf("(3) End of string: %c\n", *lastc);
  
  printf("\n");  
  return 0;
}
