#include "kernel.h"

void kernel_main()    // kernel_main - token globalized out to kernel.asm // call kernel_main ; ret ; jmp $
{
  char * video_mem = (char *) (0xB8000);
  // 0xB8000 is treated as a pointer to the original byte in video memory. 

  // Offsets : 
  video_mem[0] = 'Y';                       
  video_mem[1] = 2;
  video_mem[2] = 'e';
  video_mem[3] = 15;
  video_mem[4] = 's';
  video_mem[5] = 8;
}
