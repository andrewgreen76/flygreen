section .data
    hello db "Hello, World!",0

section .text
global _start

_start:
    ; Write "Hello, World!" to standard output (syscall number 4)
    mov eax, 4
    mov ebx, 1          ; File descriptor (1 = stdout)
    mov ecx, hello     ; Pointer to the string
    mov edx, 13         ; Length of the string
    int 0x80            ; Trigger the system call

    ; Exit the program (syscall number 1)
    mov eax, 1
    xor ebx, ebx        ; Return code 0
    int 0x80            ; Trigger the system call
