#include "io_filter.h"

//====================================================================
bool is_imgfile(char * fname)
{
  if( strstr(fname, ".jpg") || strstr(fname, ".jpeg") || strstr(fname, ".png") || strstr(fname, ".gif") || strstr(fname, ".bmp") )
    return true;
  else {
    printf("File is not an image. \n");
    return false;
  }
}

//====================================================================
bool fhere(char * fname)
{
  fname[strlen(fname)-1] = '\0'; // shave off \n with \0. 
  FILE *file = fopen(fname, "r");

  if(file) {
    fclose(file);
    return is_imgfile(fname);
  } else {
    printf("File %s does not exist. \n", fname);
    return false;
  }
}

//====================================================================
bool strfilled(char * s)
{
  if(strlen(s) > 1) return fhere(s);
  else return false;
}

//====================================================================
char * get_fname()
{
  bool good_img_name = false;
  char * named_file;
  size_t size = 0;
  
  do {
    printf("Name of target image file: ");
    
    if (getline(&named_file, &size, stdin) != -1) { 
      good_img_name = strfilled(named_file); // further checks;
    } else {
        printf("Cannot allocate memory for filename. You may be out of available memory.\n");
    }    
  } while (!good_img_name);
  free(named_file); // free() here to avoid double-free seg-fault. 

  return named_file;
}
//====================================================================
void get_bounded_vals()
{
  printf("Collecting bounded values ...\n");
  return;
}
