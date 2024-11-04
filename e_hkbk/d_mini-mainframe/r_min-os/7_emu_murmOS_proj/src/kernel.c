#include "kernel.h"
#include <stddef.h>
#include <stdint.h>
#include "idt/idt.h"
#include "io/io.h"

/*###############################################################################################*/
/*########################################## GLOBALS : ##########################################*/
/*###############################################################################################*/
#define TEXT_COLOR 2
uint16_t * video_mem = 0;
uint16_t term_row = 0;
uint16_t term_col = 0;

/*###############################################################################################*/
/*######################################### FUNCTIONS : #########################################*/
/*###############################################################################################*/

/***********************************************/
// Shapes a term char with chosen ASCII and color : 
uint16_t formch(char ch , char color)
{ return (color << 8) | ch; }    // 00000000 00000010 << 8
                                 // 00000010 00000000 or 00000000 01011001
				 // 00000010 01011001 

/***********************************************/
// Prints the formed char at fb_loc :
void stampch(int x , int y , char ch , char color){
  video_mem[y * VGA_WIDTH + x] = formch(ch , color);
}
/* Directly writing to video memory to print characters is simple enough. 
   However , we have to implement everything else , even printing a line feed. */

/***********************************************/
// Teletype action : stamps the character and moves over to next char_slot : 
void printch(char ch , char color){
  
  if(ch == '\n'){
    term_row += 1;
    term_col = 0;
  }
  
  else {  
    stampch(term_col , term_row , ch , color);
    term_col += 1;
    // handling wraparound : 
    if(term_col >= VGA_WIDTH){
      term_col = 0;
      term_row += 1;
    }
  }

  if(term_row >= VGA_HEIGHT){
    // Scrolling text upward would be nice. 
  }
  
}

/***********************************************/
// Populates 1600 spaces , clearing the screen : 
void term_init(){
  // 0xB8000 is treated as a pointer to the original byte in video memory.  
  video_mem = (uint16_t *) (0xB8000);

  term_row = 0;    // reset
  term_col = 0;
  
  for(int y=0 ; y < VGA_HEIGHT ; y++){
    for(int x=0 ; x < VGA_WIDTH ; x++){
      stampch(x , y , ' ' , 0);
    }
  }
  
}

/***********************************************/
// Returns string length : 
size_t slen(const char * str){
  size_t len = 0;

  while(str[len]){    // while not EOS
    len++;
  }

  return len;
}

/***********************************************/
void printstr(const char * str){
  size_t len = slen(str);
  
  for(int i=0 ; i < len ; i++)
    printch(str[i] , TEXT_COLOR);
}

/*###############################################################################################*/
/*######################################### MAIN LOGIC : ########################################*/
/*###############################################################################################*/

void kernel_main()    // kernel_main - token globalized out to kernel.asm // call kernel_main ; ret ; jmp $
{
  term_init();
  printstr("YES\nKing Crimson");

  idt_init();
  outb(0x60 , 0xff);
  // Moving bytes/characters via the system bus using the keyboard controller's
    // ports with `in` and `out` instructions is tested/monitored with GDB. 
}
