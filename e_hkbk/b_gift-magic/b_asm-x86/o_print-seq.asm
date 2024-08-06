	;; 
	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss
	
section .data
    strbuf db "Hello, world!", 0   ; number as string + line feed 
	
section .text
    global _start         ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
_start:
    ; Prepare for sys_write : a, b, c, d 
    mov eax, 4            ; system call number 	:  4 - sys_write (OUTPUT FILE DESCRIPTOR - file/screen) 
    mov ebx, 1            ; dest (fildescr)    	:  1 - stdout    (SCREEN) 
    mov ecx, strbuf       ; src (buffer)	: ------- string buffer ------ 
    mov edx, 14           ; srcbuf_count  	: ----- fin = len + null -----  
	;; Helloworld, ! + \0 = 14 
	
    ; Execute sys_write
    int 0x80              ; Call kernel

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
    int 0x80              ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
