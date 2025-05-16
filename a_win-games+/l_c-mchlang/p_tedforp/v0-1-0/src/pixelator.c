#include <stdio.h>
#include <stdint.h>
#include <wchar.h>
#include <locale.h>
#include "pixelator.h"

#define RES_WID 640
#define RES_HEI 320

////////////////////////////////////////////////////////////////

void clrterm(){
  printf("\033[2J\033[H");
}

void emp_chsett(){
  printf("Expanding Unicode character manipulation capabilities to \"wide\" ...\n");
  setlocale(LC_ALL , ""); 
}

void renew_chsett(){
  printf("\033[0m\n"); 
  printf("Restored character colors to default.\n");
}

void test_color(){  
  uint8_t ccode = 30; 
  printf("Performing a colored characters display test ...\n");
  
  // fg: 29-37 ; bg: 39-47 ???
  for( ; ccode<38 ; ccode++ )
    printf("\033[%d;%dm▀" , ccode , ccode+10 );
  printf("\033[0m[EOTEST]"); 
}

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

int main(){
  ////////////////// Prologue : ///////////////////
  emp_chsett();
  clrterm();
  
  /////////////////////////////////////
  test_color();
  
  ////////////////// Epilogue : ///////////////////
  renew_chsett();
  //clrterm();
  return 0;
}
