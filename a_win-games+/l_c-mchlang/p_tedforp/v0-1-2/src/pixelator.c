#include <stdio.h>
#include <stdint.h>
#include <wchar.h>
#include <locale.h>
#include "pixelator.h"

#define RES_WID 640
#define RES_HEI 320

////////////////////////////////////////////////////////////////

int main(){
  setup();
  
  test_colors();
  delay(2000000000);
  
  reset_colors();
  return 0;
}

////////////////////////////////////////////////////////////////

void setup(){
  printf("Expanding UTF-8 to local conventions ...\n");
  setlocale(LC_ALL , ""); 
}
