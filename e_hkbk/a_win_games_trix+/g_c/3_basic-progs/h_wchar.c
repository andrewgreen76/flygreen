#include <stdio.h>
#include <wchar.h>

int main() {
    wchar_t wideString[] = L"Hello, 世界!";  // Wide character string

    wprintf(L"Wide string: %ls\n", wideString);  // Print wide string using %ls format

    return 0;
}
