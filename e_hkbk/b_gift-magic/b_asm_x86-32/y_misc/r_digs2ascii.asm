	;; 512 + 128 = 640
	;; _ _ 1 0   1 0 0 0   0 1 0 1 
	
section .data		 
	result db 0       	; one-char buffer init ; null will do here. 
	newline db 10     	; 			 ASCII 10 = \n
	result_len equ $ - result ; Length of the result string

section .text
	global _start     
_start:
	mov eax, 5      ; then do 645
    add al, '0'       ; Convert to ASCII character
    mov [result], al  ; Store ASCII character in result buffer
    mov byte [result + 1], 0 ; Null terminate the string

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Prepare for sys_write
    mov eax, 4        ; sys_write system call number
    mov ebx, 1        ; File descriptor (stdout)
    mov ecx, result   ; Pointer to the result string
    mov edx, result_len ; Length of the result string
    int 0x80          ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
	mov eax, 1        ; sys_exit system call number
	xor ebx, ebx      ; Exit status (0 for success)
	int 0x80          ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
