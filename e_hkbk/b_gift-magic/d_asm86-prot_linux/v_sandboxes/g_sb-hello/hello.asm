section .data
    hello db 'Hello, Assembly!',0
    hello_len equ $ - hello

section .text
    global main

main:
    ; Prepare arguments for the write system call
    mov eax, 4         ; syscall number for sys_write (4)
    mov ebx, 1         ; file descriptor for stdout (1)
    mov ecx, hello     ; pointer to the message
    mov edx, hello_len ; length of the message

    ; Invoke the write system call
    int 0x80

    ; Exit the program
    mov eax, 1         ; syscall number for sys_exit (1)
    xor ebx, ebx       ; exit status (0)
    int 0x80
