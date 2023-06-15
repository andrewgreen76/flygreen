#include <stdio.h>

#ifndef __OS__
    #if defined(_WIN32) || defined(_WIN64)
        #define __OS__ "Windows"
    #elif defined(__APPLE__) && defined(__MACH__)
        #define __OS__ "macOS"
    #elif defined(__linux__)
        #define __OS__ "Linux"
    #else
        #define __OS__ "Unknown"
    #endif
#endif

int main() {
    printf("Current operating system: %s\n", __OS__);
    return 0;
}
