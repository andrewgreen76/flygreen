#include <stdio.h>
#include <stdint.h>
#include <wchar.h>
#include <locale.h>

#define RES_WID 640
#define RES_HEI 320

int main(){
  /////////////// Prologue /////////////// 
  setlocale(LC_ALL , "");
  wchar_t c;
  uint8_t ccode = 30; 
  ////////////////////////////////////////

  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ ){
    printf("\033[%d;%dm▀" , ccode , ccode+10 );
  }
  
  /////////////// Epilogue /////////////// 
  printf("\033[0m");
  printf( "\n" );
  return 0;
}

/*
  
FOREground :

  30 - charcoal black
  31 - red
  32 - green
  33 - golden brown
  34 - blue
  35 - purple
  36 - teal
  37 - white 
  // 29 - light grey

BACKground :

  40 - charcoal black
  41 - red
  42 - green
  43 - golden brown
  44 - blue
  45 - purple
  46 - teal
  47 - white 
  // 39 - solid black
  
 */
