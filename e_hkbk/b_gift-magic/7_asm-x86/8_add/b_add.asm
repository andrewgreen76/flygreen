section .data
    result_fmt db "Result: %d", 10, 0  ; Format string with newline character

section .bss
    sum resd 1  ; Space for a 32-bit integer result

section .text
global main
extern printf

main:
    ; Load 2 into EAX
    mov eax, 2

    ; Add 2 to EAX
    add eax, 2

    ; Store the result in the memory location [sum]
    mov [sum], eax

    ; Push arguments for printf
    push dword [sum]       ; Push the result as an argument
    push result_fmt         ; Push the address of the format string
    call printf            ; Call printf

    ; Clean up the stack after the printf call
    add esp, 8

    ; Exit the program
    mov eax, 1             ; syscall number for sys_exit
    xor ebx, ebx           ; Status code (0)
    int 0x80               ; Interrupt 0x80 for syscall (32-bit Linux)
