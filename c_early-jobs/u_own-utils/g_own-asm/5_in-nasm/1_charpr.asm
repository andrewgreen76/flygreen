section .data
    char db 'A'          ; the character to print

section .text
global _start

_start:
    mov     rax, 1       ; syscall number for write
    mov     rdi, 1       ; file descriptor 1 = stdout
    lea     rsi, [rel char] ; address of the character
    mov     rdx, 1       ; number of bytes to write
    syscall              ; invoke kernel

    mov     rax, 60      ; syscall number for exit
    xor     rdi, rdi     ; exit code 0
    syscall
