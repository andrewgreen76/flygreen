section .data
    result_msg db "Result: %d", 10, 0  ; Newline character (10) is added for readability

section .bss
    sum resb 12  ; Space for the result (12 bytes to accommodate a 32-bit integer)

section .text
global _in

_in:
    ; Load 2 into EAX
    mov eax, 2

    ; Add 2 to EAX
    add eax, 2

    ; Store the result in [sum]
    mov [sum], eax

    ; Prepare for syscall to print the result
    mov rdi, 1             ; File descriptor 1 (STDOUT)
    lea rsi, [result_msg]  ; Load address of the result_msg string
    mov rdx, 13            ; Length of the string (including null terminator)

    ; Make the syscall to print the result
    mov rax, 1             ; syscall number for sys_write
    syscall

    ; Exit the program
    mov rax, 60            ; syscall number for sys_exit
    xor rdi, rdi           ; Status code (0)
    syscall
