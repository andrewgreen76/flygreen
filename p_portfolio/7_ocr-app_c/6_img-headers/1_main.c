#include <stdio.h>

#pragma pack(push, 1)
char b;
#pragma pack(pop)



int main(int argc, char * argv[])
{
  printf("\n");
  /*
  char * fname = argv[1];
  char * mode = argv[2];
  printf("char * fname : %s\n", fname);
  printf("char * mode: %s\n\n", mode);
  */
  FILE *f_at = fopen("3.bmp", "rb");
  if(f_at) {
    printf("Target file found\n");
    fread(&b, sizeof(char), 1, f_at);
    //printf("%s\n", b);
    fclose(f_at);
  }
  else printf("Target file **not** found\n");  

  printf("\n");
  return 0;
}
