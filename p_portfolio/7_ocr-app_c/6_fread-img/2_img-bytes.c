#include <stdio.h>
#include <stdint.h>

#define USE_UINT32_T 1

#if USE_UINT32_T 
uint32_t b;
#else
#pragma pack(push, 1)
char b;
#pragma pack(pop)
#endif



int main(int argc, char * argv[])
{
  printf("\n");
  /*
  char * fname = argv[1];
  char * mode = argv[2];
  printf("char * fname : %s\n", fname);
  printf("char * mode: %s\n\n", mode);
  */
  FILE *f_at = fopen(argv[1], argv[2]);
  if(f_at) {
    printf("Target file found\n");

    for(int t=0; t<54; t++) {
      fread(&b, sizeof(char), 1, f_at);
      if(t%16 == 0 && t!=0) printf("\n");
      printf("%02X ", b);
    }
    printf("\n");
    fclose(f_at);
  }
  else printf("Target file **not** found\n");  

  printf("\n");
  return 0;
}
