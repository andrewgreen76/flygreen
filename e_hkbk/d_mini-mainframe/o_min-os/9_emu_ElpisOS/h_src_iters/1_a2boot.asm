
	ORG 0x7c00		; One way to store code at 0x7C00. 
	BITS 16			

start:
	mov ah , 0eh
	mov al , 'A'
	int 0x10

	jmp $

	times 510-($-$$) db 0	
	dw 0xAA55
