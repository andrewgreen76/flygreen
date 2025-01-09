#include "img_proc.h"

void get_img_props(ProcList * pm, BmpHeader * imgh54)
{
  printf("Caching image data from %s\n", pm->fname);

  FILE *srcbmp = fopen(pm->fname, "rb");
  fread(imgh54, sizeof(imgh54), 1, srcbmp);

  printf("Signature: %c%c\n", (char)(imgh54->signature & 0xFF), (char)((imgh54->signature & 0xFF00) >>8) ); 
  printf("Total size of header: %d\n", imgh54->fileSize);
  printf("Reserved field check: %d\n", imgh54->reserved);
  
  fclose(srcbmp);
  return;
}

void proc_img()
{
    printf("Processing image ...\n");

    return;
}

