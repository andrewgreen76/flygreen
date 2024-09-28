
	ORG 0x7c00 		 
	BITS 16			

start:
	mov ah , 0eh
	mov al , 'A'
	int 0x10		 

	times 510-($-$$) db 0	
	dw 0xAA55
