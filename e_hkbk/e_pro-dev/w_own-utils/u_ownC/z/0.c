#include <stdio.h>

int main() {
    printf("Size of FILE: %zu bytes\n", sizeof(FILE));
    printf("Size of FILE * : %zu bytes\n", sizeof(FILE * ));
    return 0;
}
