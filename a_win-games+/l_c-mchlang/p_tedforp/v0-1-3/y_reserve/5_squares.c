#include <stdio.h>
#include <wchar.h>
#include <locale.h>

int main(){

  setlocale(LC_ALL , "");

  //for(wchar_t c = L'\u2580' ; c<L'\u2590' ; c++) wprintf( L"%lc\n" , c );
  wchar_t c = L'\u2580';
  wprintf( L"%lc" , c );
  c = L'\u2584';
  wprintf( L"%lc" , c );

  wprintf( L"\n" );

  return 0;
}
