#include "io_filter.h"

void warn_segf()
{
  char * k;
  printf("**WARNING: POTENTIAL IMPENDING SEGFAULT.** Hit ENTER to continue or C^c to abort. \n");
  scanf("%s", k);
}

//====================================================================
bool is_imgfile(char * fname)
{
  if( strstr(fname, ".jpg") || strstr(fname, ".jpeg") || strstr(fname, ".png") || strstr(fname, ".gif") || strstr(fname, ".bmp") ) {
    printf("First check of \"3.bmp\" against : %s\n", fname);
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
char * get_fname()
{
  bool is_iname_good = false;
  char * named_file;
  size_t size = 0;
  
  do {
    printf("Name of target image file: ");
    if( scanf("%s", named_file)>0 ) {
      printf("Received input : %s\n", named_file);
      is_iname_good = strfilled(named_file); // further checks;
    } else {
        printf("Cannot allocate memory for filename. You may be out of available memory.\n");
    }    
  } while (!is_iname_good);
  // Here we are expecting a good file name:
  printf("Second check of \"3.bmp\" against : %s\n", named_file);  

  // DO I WANT TO RETURN THE CHAR*VAL OR FREE THE STRING MEM ?? 
  //free(named_file); // free() here to avoid double-free seg-fault. 

  return named_file;
}
//====================================================================
void get_bounded_vals()
{
  printf("Collecting bounded values ...\n");
  return;
}
