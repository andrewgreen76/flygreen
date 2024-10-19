
	;; Imagine a "string print" assembly program that takes a number, formatted as a string ("645") ,
	;; and prints it as a string. Feeding a specific number directly as a string is easy. But what if
	;; we want to introduce a piece of data as a pure integer (645) and print that ? How do we do that ?
	;; We have to render the integer as a string first and then display it.

	;; We can read individual digits of the value and display them. The question is : do we go left-to-right or right-to-left ?
	;; It's easier to detect the most significant digit by skipping all the zeros from the left. 
	
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

	;; A 32-bit register (eax , ebx , etc.) can only use 32 bits to support an integer 
	;; up to a certain maximal value = (2^32)-1 = 4294967295 (10 chars). 
	
	;; The `ecx` register in x86 assembly can accommodate up to 10 decimal digits.
	;; This is because the maximum value it can hold, \(2^{32} - 1\), when converted
	;; to decimal, is 4,294,967,295 (4294967295), which consists of 10 digits. Therefore, `ecx`
	;; can be used to count or represent up to 10 decimal digits in assembly programming contexts.
	;; 
