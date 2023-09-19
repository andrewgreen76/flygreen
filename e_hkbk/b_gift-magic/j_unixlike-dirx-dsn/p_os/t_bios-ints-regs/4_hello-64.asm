section .data
    hello db "Hello, World!",0

section .text
global _start

_start:
    ; Write "Hello, World!" to standard output (syscall number 1)
    mov rax, 1          ; System call number for write
    mov rdi, 1          ; File descriptor (1 = stdout)
    mov rsi, hello     ; Pointer to the string
    mov rdx, 13         ; Length of the string
    syscall             ; Trigger the system call

    ; Exit the program (syscall number 60)
    mov rax, 60         ; System call number for exit
    xor rdi, rdi        ; Return code 0
    syscall             ; Trigger the system call
