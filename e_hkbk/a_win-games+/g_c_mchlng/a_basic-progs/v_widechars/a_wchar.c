#include <stdio.h>
#include <wchar.h>

int main() {
    wchar_t* wideString = L"Hello, 世界!";
    
    wprintf(L"The wide string is: %ls\n", wideString);

    return 0;
}
