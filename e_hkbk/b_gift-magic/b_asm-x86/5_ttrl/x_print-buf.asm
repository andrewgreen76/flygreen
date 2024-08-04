	;; 
	
section .data
    strbuf db "Hello, world!", 0xA   ; number as string + line feed 

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text
    global _start         ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
_start:
    ; Prepare for sys_write : a, b, c, d 
    mov eax, 4            ; system call number 	:  4 - sys_write (OUTPUT FILE DESCRIPTOR - file/screen) 
    mov ebx, 1            ; dest (fildescr)    	:  1 - stdout    - SCREEN
    mov ecx, strbuf       ; src (buffer)	: string buffer 
    mov edx, 14           ; strlen + delim	: how much : all of it w/ delim 

    ; Execute sys_write
    int 0x80              ; Call kernel

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
    int 0x80              ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
