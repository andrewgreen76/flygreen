#include "img_proc.h"

void get_img_props(ProcList * pm, BmpHeader * h54)
{
    printf("Caching image data ...\n");

    FILE *f = fopen(pm.fname, "rb");
    if(f) {
      printf("File found\n");
      fclose(f);
    }
    else printf("Cannot open file\n");
}

void proc_img()
{
    printf("Processing image ...\n");
}

