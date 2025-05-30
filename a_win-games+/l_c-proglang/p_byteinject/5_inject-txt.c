#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

int main(){
  int fid = open( "target.txt" , O_WRONLY | O_CREAT | O_TRUNC , 0644 );
  const char * test_text = "Mary had a little lamb,\nIts fleece was white as snow.\n";
  write( fid , test_text , strlen(test_text) );

  close(fid);  
  return 0;
}
