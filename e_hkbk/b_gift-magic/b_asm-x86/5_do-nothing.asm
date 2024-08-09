
	;; A basic assembly program that does nothing.
	;; This is just a breakdown of the entry and exit points. 
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;				START 				  ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; DATA SEGMENT usually goes here. 
;; We'll just start off with no data. This is just code to get in and out. 
	
; CODE SEGMENT
section .text
	global _start         ; Entry point for linking
	
_start:
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;			  FINISH BY EXITING		  	  ;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
    ; Exit the program
	mov eax, 1	; sys_exit system call number
	xor ebx, ebx    ; Returns exit status 0 for success (in case if a program like the kernel asks) 
			; Not a necessity for our purposes. 
			; Not 'mov ebx, 0' for optimization reasons. 
	int 0x80        ; Call kernel

	;; 
