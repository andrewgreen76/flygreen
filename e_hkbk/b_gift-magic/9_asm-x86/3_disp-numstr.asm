	;; 
	
section .data
    number db "645", 0xA   ; number as string + line feed 

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text
    global _start         ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
_start:
    ; Prepare for sys_write : a, b, c, d 
    mov eax, 4            ; system call number 	: sys_write 
    mov ebx, 1            ; file descriptor    	: stdout 
    mov ecx, number       ; buffer 		: string 
    mov edx, 4            ; strlen + delim	: [know this ahead of time] 

    ; Execute sys_write
    int 0x80              ; Call kernel

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
    int 0x80              ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
