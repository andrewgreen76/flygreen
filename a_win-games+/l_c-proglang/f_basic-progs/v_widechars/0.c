#include <stdio.h>
#include <wchar.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "en_US.UTF-8");  // Ensure UTF-8 locale
    wchar_t ch = L'\u2554';  // Unicode character for box-drawing corner
    wprintf(L"%lc\n", ch);   // Print the wide character

    return 0;
}
