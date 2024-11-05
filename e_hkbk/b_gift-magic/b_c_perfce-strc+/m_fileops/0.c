#include <stdio.h>

#define OBUF_SIZE 10

int main() {
  FILE * ifile = fopen("msg.txt","r");
  if (!ifile) {
    printf("\nCannot locate input file\n");
    return -1;
  }

  char obuf [OBUF_SIZE];
  int rd_size = 1;  // 1 byte at a time 
  int rd_count = 4; // read 3 bytes. Attempting to fread more will default to what is capped by '\0'. 
  
  int bytes_read = fread( obuf , rd_size , rd_count , ifile );

  for(int bytes_parsed = 0 ; bytes_parsed < bytes_read ; bytes_parsed++){
    printf("%c" , obuf[bytes_parsed]);
  }

  return 0 ; 
}
