section .data
    buffer db 0           ; Buffer to hold ASCII characters (initially empty)
    buffer_len equ $ - buffer  ; Length of the buffer

section .text
    global _start
_start:
    ; Convert the number 645 to ASCII characters in reverse order
    mov eax, 645         ; Load the number to convert
    mov ecx, buffer + 10 ; Point to the end of buffer (reserve space for digits)

    convert_loop:
        mov edx, 0       ; Clear edx for division
        mov ebx, 10      ; Divisor for decimal digits
        div ebx          ; Divide eax by ebx (edx:eax = eax / ebx, remainder in edx)

        add dl, '0'      ; Convert remainder to ASCII digit
        dec ecx          ; Move to the previous byte in buffer
        mov [ecx], dl    ; Store ASCII digit in buffer

        test eax, eax    ; Check if eax is zero (end of number)
        jnz convert_loop ; If not zero, continue converting digits

    ; Print the ASCII string stored in buffer (using sys_write or similar)
    mov eax, 4           ; sys_write system call number
    mov ebx, 1           ; File descriptor (stdout)
    lea ecx, [ecx]       ; Load effective address of buffer
    mov edx, buffer_len  ; Length of the buffer
    int 0x80             ; Call kernel to output the string

    ; Exit the program
    mov eax, 1           ; sys_exit system call number
    xor ebx, ebx         ; Exit status (0 for success)
    int 0x80             ; Call kernel to exit
