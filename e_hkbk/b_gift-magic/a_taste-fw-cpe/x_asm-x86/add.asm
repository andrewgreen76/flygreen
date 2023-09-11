section .data
    result_msg db "Result: %d", 10, 0  ; Newline character (10) is added for readability

section .bss
    sum resb 12  ; Space for the result (12 bytes to accommodate a 32-bit integer)

section .text
global main

main:
    ; Load 2 into EAX
    mov eax, 2

    ; Add 2 to EAX
    add eax, 2

    ; Store the result in the memory location [sum]
    mov [sum], eax

    ; Prepare for syscall to print the result
    mov ebx, 1             ; File descriptor 1 (STDOUT)

    ; Calculate the address of the result_msg string with RIP-relative LEA
    lea ecx, [rel result_msg]

    ; Calculate the length of the string (including null terminator)
    lea edx, [ecx + 13]

    ; Make the syscall to print the result
    mov eax, 4             ; syscall number for sys_write
    int 0x80               ; Interrupt 0x80 for syscall (32-bit Linux)

    ; Exit the program
    mov eax, 1             ; syscall number for sys_exit
    xor ebx, ebx           ; Status code (0)
    int 0x80               ; Interrupt 0x80 for syscall (32-bit Linux)
