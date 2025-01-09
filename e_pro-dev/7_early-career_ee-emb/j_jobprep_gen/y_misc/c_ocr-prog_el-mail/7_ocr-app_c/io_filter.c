#include "io_filter.h"

//====================================================================
bool is_imgfile(char * fname)
{
  if( strstr(fname, ".jpg") || strstr(fname, ".jpeg") || strstr(fname, ".png") || strstr(fname, ".gif") || strstr(fname, ".bmp") ) {
    //printf("First check of \"3.bmp\" against : %s\n", fname);
    return true;
  }
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
bool is_short(char * named_file)
{
  if( named_file[199] == '\0' )
    return strfilled(named_file);
  else {
    printf("Input is too long.\n");
    return false; 
  }
}

//====================================================================
void get_fname(char * named_file)
{
  bool is_iname_good = false;
  
  do {
    printf("Name of target image file: ");
    if( fgets(named_file, sizeof(named_file), stdin) != NULL ) // no-str check
      is_iname_good = is_short(named_file);                 // too-long, further checks;
  } while (!is_iname_good);

  return;
}
//====================================================================
void get_bounded_vals()
{
  printf("Collecting bounded values ...\n");
  return;
}
