#include <fcntl.h>   // for open() 
#include <unistd.h>  // for close() 

void main(){
  int tgt_fid = open( "9_hexd-tgt.txt", O_WRONLY | O_CREAT, 0644 );
  char wrbyte = 0x42;
  write(tgt_fid , &wrbyte , 1); 
  close(tgt_fid);
}
