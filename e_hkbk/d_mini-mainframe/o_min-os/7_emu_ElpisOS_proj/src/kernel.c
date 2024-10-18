#include "kernel.h"

void kernel_main()
{
  char * video_mem = (char *) (0xB8000);
  video_mem[0] = 'Y';
  video_mem[1] = 2;
  video_mem[2] = 'e';
  video_mem[3] = 15;
  video_mem[4] = 's';
  video_mem[5] = 8;
}
