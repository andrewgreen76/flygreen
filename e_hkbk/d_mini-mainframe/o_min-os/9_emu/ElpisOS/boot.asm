
	ORG 0x7c00 		 
	BITS 16			

start:
	mov si , msg
	call print 
	jmp $

print:				; mov bx , 0
.loop:	
	lodsb
	cmp al , 10
	je .done
	call printch
	jmp .loop
.done:	
	ret
	
printch:	
	mov ah , 0eh
	int 0x10
	ret

msg:	db 'Hello, World!', 10

	times 510-($-$$) db 0	
	dw 0xAA55
