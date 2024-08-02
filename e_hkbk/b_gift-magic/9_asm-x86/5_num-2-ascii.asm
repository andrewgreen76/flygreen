section .data
    result db 0        ; Reserve space for the result string
    newline db 10     ; Newline character
    result_len equ $ - result ; Length of the result string

section .text
    global _start     ; Entry point for linking

_start:
    ; Compute the number to display
    mov eax, 645      ; Move the integer 645 into eax

    ; Convert integer to string
    mov ebx, 10       ; Divide by 10
    div ebx           ; eax = eax / 10 (quotient), edx = eax % 10 (remainder)
    add dl, '0'       ; Convert remainder to ASCII character

    mov [result], dl  ; Store ASCII character in result buffer
    mov byte [result + 1], 0 ; Null terminate the string

    ; Prepare for sys_write
    mov eax, 4        ; sys_write system call number
    mov ebx, 1        ; File descriptor (stdout)
    mov ecx, result   ; Pointer to the result string
    mov edx, result_len ; Length of the result string

    ; Execute sys_write to print the number
    int 0x80          ; Call kernel

    ; Print a newline
    mov eax, 4        ; sys_write system call number
    mov ebx, 1        ; File descriptor (stdout)
    mov ecx, newline  ; Pointer to the newline character
    mov edx, 1        ; Length of the newline character

    ; Execute sys_write to print the newline
    int 0x80          ; Call kernel

    ; Exit the program
    mov eax, 1        ; sys_exit system call number
    xor ebx, ebx      ; Exit status (0 for success)
    int 0x80          ; Call kernel
