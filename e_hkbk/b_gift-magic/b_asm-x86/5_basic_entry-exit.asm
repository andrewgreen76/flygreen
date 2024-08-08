
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;				START 				  ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
section .text		  ; CODE SEGMENT 
    global _start         ; Entry point for linking
_start:

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;			       FINISH 				  ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
			  ; not 'mov ebx, 0' for optimization reasons 
    int 0x80              ; Call kernel

	;; 
