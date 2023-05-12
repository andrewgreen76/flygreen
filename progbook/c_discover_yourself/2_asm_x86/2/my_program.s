section .data
    message db 'a', 0

section .text
    global _start

_start:
    ; Write the character to the standard output
    mov eax, 4        ; System call number for write
    mov ebx, 1        ; File descriptor 1: standard output
    mov ecx, message  ; Address of the character
    mov edx, 1        ; Length of the character
    int 0x80          ; Call the kernel

    ; Exit the program
    mov eax, 1        ; System call number for exit
    xor ebx, ebx      ; Exit code 0
    int 0x80          ; Call the kernel
