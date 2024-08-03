.data
    message:    .asciz "Hello, World!\n"

.text
.global main

main:
    # Write the string to the standard output
    mov     $4, %eax          # System call number for write
    mov     $1, %ebx          # File descriptor 1: standard output
    mov     $message, %ecx    # Address of the string
    mov     $14, %edx         # Length of the string
    int     $0x80             # Call the kernel

    # Exit the program
    mov     $1, %eax          # System call number for exit
    xor     %ebx, %ebx        # Exit code 0
    int     $0x80             # Call the kernel
