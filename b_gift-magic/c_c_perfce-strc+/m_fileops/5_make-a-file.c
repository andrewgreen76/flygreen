#include <fcntl.h>   // for open() 
#include <unistd.h>  // for close() 

void main(){
  int fid_1 = open( "1_tgt.txt", O_WRONLY | O_CREAT, 0644 );
  close(fid_1);
}
