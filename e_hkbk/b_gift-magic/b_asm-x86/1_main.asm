section .data
    my_integer dd 5   ; Define a 32-bit integer initialized to 5

section .text
    global _start

_start:
    ; No instructions here
    ; The program simply starts and exits immediately

    ; Exit the program
    mov eax, 1      ; sys_exit system call number
    xor ebx, ebx    ; Exit status (0 for success)
    int 0x80        ; Call kernel
