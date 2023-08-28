#include <stdio.h>

//#pragma pack(push, 1)
char b;
//#pragma pack(pop)
// ... or this with <stdint.h> : 
//uint32_t b;



int main(int argc, char * argv[])
{
  printf("\n");
  /*
  char * fname = argv[1];
  char * mode = argv[2];
  printf("char * fname : %s\n", fname);
  printf("char * mode: %s\n\n", mode);
  */
  FILE *f_at = fopen("2.txt", "rb");
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
