#include <stdio.h>

char b;

int main(int argc, char * argv[])
{
  printf("\n");

  FILE *f_at = fopen("5.txt", "rb");
  if(f_at) {
    printf("Target file found\n");

    for(int t=0; t<8; t++) {
      fread(&b, sizeof(char), 1, f_at);
      printf("Byte : %c\n", b);
    }
    
    fclose(f_at);
  }
  else printf("Target file **not** found\n");  

  printf("\n");
  return 0;
}
