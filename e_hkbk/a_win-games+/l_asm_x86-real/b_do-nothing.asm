
	;; The code here written in this fashion is meant for systems
	;; that natively only support the real mode (16-bit systems).
	;; 
	;; This is to be assembled by the emu8086 application on Windows. 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Pre- main entry directives : 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	org 100h    	; The code below (here it's just one instruction) will be
			; placed at this address - the OFFSET from the start of
			; the memory layout of the process. 
			;; 
			;; This is NOT an absolute address. 
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;; DOS kernel gives this program the CONTROL OVER THE CPU. 
	;; We start execution of the MAIN CODE of the program.
	;; We get into the main SUBROUTINE ... 
	
	ret         	; ... and we get out.
			; (This is the exit point from the main subroutine).

	;; Upon termination of this process we give control over the CPU back to the DOS kernel. 

	;; 
