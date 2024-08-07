section .data		 
    result db 0       	; buffer init ; ASCII  0 = \0
    newline db 10     	; 		ASCII 10 = \n
    result_len equ $ - result ; Length of the result string

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text
    global _start     ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_start:
    mov eax, 5      ; then do 645

    ; Convert integer to string
    mov ebx, 10       ; manual : eax <- dividend , ebx <- divisor
    div ebx           ; operat : eax <- quotient , edx <- remainder 
    add dl, '0'       ; Convert remainder to ASCII character

    mov [result], dl  ; Store ASCII character in result buffer
    mov byte [result + 1], 0 ; Null terminate the string

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Prepare for sys_write
    mov eax, 4        ; sys_write system call number
    mov ebx, 1        ; File descriptor (stdout)
    mov ecx, result   ; Pointer to the result string
    mov edx, result_len ; Length of the result string

    ; Execute sys_write to print the number
    int 0x80          ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Print a newline
    mov eax, 4        ; sys_write system call number
    mov ebx, 1        ; File descriptor (stdout)
    mov ecx, newline  ; Pointer to the newline character
    mov edx, 1        ; Length of the newline character

    ; Execute sys_write to print the newline
    int 0x80          ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
	mov eax, 1        ; sys_exit system call number
	xor ebx, ebx      ; Exit status (0 for success)
	int 0x80          ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
