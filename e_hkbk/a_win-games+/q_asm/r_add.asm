section .data
    result db "Result: ", 0

section .bss
    sum resb 1

section .text
global main

main:
    ; Clear AL register (optional)
    xor al, al

    ; Load 2 into AL register
    add al, 2

    ; Add 2 to AL register
    add al, 2

    ; Convert the result to ASCII and store in [sum]
    add al, '0'
    mov [sum], al

    ; Print the result
    mov eax, 4         ; syscall number for sys_write (STDOUT)
    mov ebx, 1         ; file descriptor (STDOUT)
    mov ecx, result    ; pointer to the string
    mov edx, 8         ; length of the string
    int 0x80           ; syscall interrupt

    ; Exit the program
    mov eax, 1         ; syscall number for sys_exit
    int 0x80           ; syscall interrupt
