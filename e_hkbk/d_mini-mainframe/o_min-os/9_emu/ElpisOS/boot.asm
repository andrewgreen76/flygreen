
	ORG 0			 
	BITS 16			
				 
_start:
	jmp short ld_btld
	nop 			 
	times 33 db 0 	; Faked all {0x03 -> 0x35} data bytes for BPB / 512. 

ld_btld:
	jmp 0x07c0:at_7c00 ; Manual load of CS:IP. 
	
at_7c00:	
	cli			
	mov ax , 0x07c0	 	 
	mov ds , ax 	; DS = 0x7C00
	mov es , ax	; ES = -//-
	mov ax , 0x00
	mov ss , ax	; SS:0 is RAM:0
	mov sp , 0x7c00 	
	sti 
	;;; MAPPING ADDRESSES OF CUSTOM INTS TO MAKE IVT ;;;;;;;;;;;;;
	;;; PROGRAMMING LOGIC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	jmp $			
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
print_msg:
	mov ah , 0eh
.chk_char:			 
	lodsb
	cmp al , 0 
	je .out			
	int 0x10		 
	jmp .chk_char		 
.out:
	ret

	;;; 1st sector has the code below for populating hardcoded chars. ;;;;;;;;;;;;;

	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - in text). ;;;;;;;;;;;;;;;;

	
