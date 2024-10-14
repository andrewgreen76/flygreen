
;;; 32-BIT CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	[BITS 32] 		
	
init_prot_regs:
	mov ax , DATA_SEG
	mov ds , ax
	mov es , ax
	mov fs , ax
	mov gs , ax
	mov ss , ax
	mov ebp , 0x00200000 	; past A20 (1 MB) , into 2 MB 
	mov esp , ebp 		; 

	in al, 0x92
	or al, 2		; enable A20 line (for access to the bottom 16 MB memory) 
	out 0x92, al
	
	jmp $ 			; "halt"

	;; 
