	;; 
	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss
	
section .data
strbuf_addr db "Hello, world!", 0   	; strbuf is a LOCATION
	
					; db = define bytes at this location : string + \0
	
					;; Certain assembly operations and routines can produce desired results
					;; only when there is an end to the sequence of bytes , so appending
					;; the null terminator is standard practice. 
	
section .text
global _start         ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
_start:
    ; Prepare for sys_write : a, b, c, d 
	mov eax, 4            ; system call number 	:  4 - sys_write (OUTPUT FILE DESCRIPTOR - file / peripheral) 
	mov ebx, 1            ; dest (fildescr)    	:  1 - stdout    (PERIPHERAL OUTPUT - screen, sound, printing, net) 
	mov ecx, strbuf_addr  ; src (buffer addr)	: undisclosed memory location of the string buffer 
	mov edx, 14           ; byte count : when do I stop ?  : 14 = |Helloworld, !| + |\0| - all bytes (reg.chars + spec.chars) 
	
    ; Execute sys_write
	int 0x80              ; Call kernel

	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Exit the program
	mov eax, 1            ; sys_exit system call number
	xor ebx, ebx          ; Exit status (0 for success)
	int 0x80              ; Call kernel
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
