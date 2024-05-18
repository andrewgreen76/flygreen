    .text
    .globl _start

_start:
    # Load the first number (2) into register eax
    movl    $2, %eax

    # Add the second number (3) to eax
    addl    $3, %eax

    # Exit the program
    movl    $1, %eax          # syscall number for exit
    xorl    %ebx, %ebx        # exit status 0
    int     $0x80             # invoke syscall
