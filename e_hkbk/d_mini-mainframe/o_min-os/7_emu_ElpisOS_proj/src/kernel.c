#include "kernel.h"
#include <stdint.h>

uint16_t print_termch(char c , char color)
{
  return (color << 8) | c;
  /*
        00000000 00000010 << 8
        00000010 00000000 or 00000000 01011001 
        00000010 01011001
   */
}

void kernel_main()    // kernel_main - token globalized out to kernel.asm // call kernel_main ; ret ; jmp $
{
  // 0xB8000 is treated as a pointer to the original byte in video memory.  
  uint16_t * video_mem = (uint16_t *) (0xB8000);

  video_mem[0] = print_termch('Y' , 2);
  video_mem[1] = print_termch('e' , 15);
  video_mem[2] = print_termch('s' , 8);
}


/*###############################################################################################*/
/*###############################################################################################*/
/*###############################################################################################*/
  /* 
  char_t * video_mem = (char *) (0xB8000);
  video_mem[0] = 'Y';                       
  video_mem[1] = 2;
  video_mem[2] = 'e';
  video_mem[3] = 15;
  video_mem[4] = 's';
  video_mem[5] = 8;
   */
  
  /*

  // FRAMEBUFFER OFFSETS :
  //
  // The compiler will figure out the actual framebuffer offsets and their values 
  //   based on (1) 'short' (taking up 2 bytes) and (2) little-endianness. 
  video_mem[0] = 0x0259;    // {green , 'Y'} *** {color,char} - because of little-endianness. 
  video_mem[1] = 0x0f65;    
  video_mem[2] = 0x0873;

   */
