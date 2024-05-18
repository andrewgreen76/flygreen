.section .data
    num1:   .long 10          # Define the first number
    num2:   .long 20          # Define the second number
    result: .long 0           # Define a variable to store the result

.section .text
.global _start

_start:
    # Load the first number into register eax
    movl    num1, %eax

    # Add the second number to eax
    addl    num2, %eax

    # Store the result in the result variable
    movl    %eax, result

    # Exit the program
    movl    $1, %eax          # syscall number for exit
    xorl    %ebx, %ebx        # exit status 0
    int     $0x80             # invoke syscall
