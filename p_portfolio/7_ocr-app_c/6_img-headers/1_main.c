#include <stdio.h>

int main(int argc, char * argv[])
{
  printf("\n");
  char * b;

  char * f = argv[1];
  char * m = argv[2];
  printf("char * f : %s\n", f);
  printf("char * m : %s\n\n", m);

  // scanf() trial :
  int num;
  printf("Enter num : ");
  scanf("%d", &num);
  printf("You've entered : %d\n", num);
  
  /*
  FILE *file_at = fopen(f, m);

  if(file_at) {
    printf("File %s found\n", f);
    //    fread(b, sizeof(char), 1, file_at);
    //printf("%s\n", b);
  }
  */

  printf("\n");
  return 0;
}
