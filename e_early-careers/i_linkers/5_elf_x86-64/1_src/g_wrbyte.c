#include <fcntl.h>   // for open() 
#include <unistd.h>  // for close() 

void main(){
  int fid_tgt = open( "z_tgt.txt", O_WRONLY | O_CREAT, 0644 );
  char wrbyte = 65;
  write(fid_tgt , &wrbyte , 1); 
  close(fid_tgt);
}
