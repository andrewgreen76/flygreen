
	;; The code here written in this fashion is meant for systems
	;; that natively only support the real mode (16-bit systems).
	;; 
	;; This is to be assembled by the emu8086 application on Windows. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
; Pre- main entry directives : 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             

	org 100h    ; The code below will be placed at this address 
		    ; (OFFSET) within the memory layout of the process. 
		    ;; This is NOT an absolute address. 
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
;
; Memory segment : 
;
;  @   0h : Program Segment Prefix (PSP) in a DOS .COM file
;            . environment variables 
;            . other info 
;
;  @ 100h : the OFFSET within the process layout 
;           where the code segment is to be situated 
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             

	ret         ; exit point (from the subroutine)
		    ;; 
