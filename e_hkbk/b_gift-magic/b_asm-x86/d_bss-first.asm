
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;				START 				 ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;; DATA SEGMENTS :  ;;;;;;;;;;;;;;;;;;;;;;;
section .bss			; for uninitialized data 
	
section .data			; for initialized data

;;;;;;;;;;;;;;;;;;; Open the CODE SEGMENT with :  ;;;;;;;;;;;;;;;;;;
section .text			
global _start         ; Entry point for linking	
_start:
;;;;;;;;;;;;;;;;;;;; Then your code goes below : ;;;;;;;;;;;;;;;;;;;

	;; 
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;			       FINISH 				  ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
    int 0x80              ; Call kernel

	;; 
