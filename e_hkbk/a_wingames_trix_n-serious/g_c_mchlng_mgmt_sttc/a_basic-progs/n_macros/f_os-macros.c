#include <stdio.h>

// v Bad practice. 
    #if defined(_WIN32) || defined(_WIN64)
    #define __blahblah__ "Windows"   // Also bad practice. 
#elif defined(__linux__)
    #define __blahblah__ "Linux"
#else
    #define __blahblah__ "Unknown"
#endif

int main() {
    printf("Current operating system: %s\n", __blahblah__);
    return 0;
}
