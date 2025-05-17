#include <stdio.h>
#include <wchar.h>
#include <locale.h>

#define TRY_SMTH 1

int main(){
  /////////////// Prologue /////////////// 
  setlocale(LC_ALL , "");
  wchar_t c;
  //////////////////////////////////////// 

  printf("\033[32;45m▀");
  //printf("\033[31;47m▁");
  //printf("\033[31;47m▄");
  
  /////////////// Epilogue /////////////// 
  printf("\033[0m");
  printf( "\n" );
  return 0;
}

/*
  31 - red
  32 - green
  45 - pale purple 
  46 - teal
  47 - white
 */
