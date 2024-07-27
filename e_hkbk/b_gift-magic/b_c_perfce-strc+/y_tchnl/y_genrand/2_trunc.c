#include <stdio.h>
#include <stdint.h>

int main() {
    // Original pointer value
    uintptr_t ptr_value = 0x7fff9b17e124;

    // Truncate the least significant nibble
    uintptr_t truncated_ptr = ptr_value & ~0xF;  // Bitwise AND with a bitmask

    // Print the original and truncated pointer values
    printf("Original pointer value: 0x%lx\n", ptr_value);
    printf("Truncated pointer value: 0x%lx\n", truncated_ptr);

    return 0;
}
