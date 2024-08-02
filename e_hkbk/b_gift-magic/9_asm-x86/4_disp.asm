section .data
    result_msg db 'Result: ', 0   ; Message to display result
    newline db 10, 0              ; Newline character for formatting

section .bss
    result resd 1                 ; Reserve space for a 32-bit integer (result)

section .text
    global _start   ; Entry point for the program

_start:
    ; Calculate the result
    mov eax, 213    ; Load first number into EAX
    add eax, 432    ; Add second number to EAX
    mov [result], eax  ; Store the result in 'result'

    ; Display the result
    ; Print the message
    mov eax, 4      ; sys_write syscall number
    mov ebx, 1      ; File descriptor (stdout)
    mov ecx, result_msg  ; Message to print
    mov edx, 8      ; Length of the message
    int 0x80        ; Call kernel to print message

    ; Print the result
    mov eax, 4      ; sys_write syscall number
    mov ebx, 1      ; File descriptor (stdout)
    mov ecx, result ; Address of the result variable
    mov edx, 4      ; Number of bytes to print (assuming 32-bit integer)
    int 0x80        ; Call kernel to print result

    ; Print a newline for formatting
    mov eax, 4      ; sys_write syscall number
    mov ebx, 1      ; File descriptor (stdout)
    mov ecx, newline ; Newline character
    mov edx, 1      ; Length of the newline character
    int 0x80        ; Call kernel to print newline

    ; Exit the program
    mov eax, 1      ; sys_exit syscall number
    xor ebx, ebx    ; Exit code 0
    int 0x80        ; Call kernel to terminate program
