#include "kernel.h"

void kernel_main()
{
  char * video_mem = (char *) (0xB8000);
  video_mem[0] = 'A';
  video_mem[1] = 2;
}
