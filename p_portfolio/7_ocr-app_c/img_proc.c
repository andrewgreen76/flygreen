#include "img_proc.h"

void get_img_props(ProcList * pm, BmpHeader * h54)
{
    printf("Caching image data ...\n");

    //assert(pm->fname == "3.bmp");
    //printf("pm->fname : %s\n", pm->fname);
    FILE *f = fopen(pm->fname, "rb");
    if(f) {
      printf("File found\n");
      fclose(f);
    }
    else printf("**ERROR: Cannot open file**\n");
}

void proc_img()
{
    printf("Processing image ...\n");
}

