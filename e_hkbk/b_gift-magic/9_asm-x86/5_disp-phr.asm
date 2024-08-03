	;; 
	
section .data
    number db "Hello, world!", 0xA   ; number as string + line feed 

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text
    global _start         ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
_start:
    ; Prepare for sys_write : a, b, c, d 
    mov eax, 4            ; system call number 	: sys_write - OUTPUT 
    mov ebx, 1            ; file descriptor    	: stdout    - SCREEN
    mov ecx, number       ; buffer 		: string    - TARGET 
    mov edx, 14            ; strlen + delim	: how much is all of it w/ delim 

    ; Execute sys_write
    int 0x80              ; Call kernel

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
    int 0x80              ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
