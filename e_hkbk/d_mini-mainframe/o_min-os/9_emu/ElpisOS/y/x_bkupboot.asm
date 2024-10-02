
	ORG 0x7c00 		 
	BITS 16			

start:
	mov si , msg
	call print_msg 
	jmp $			; "halting" point

print_msg:
.chk_char:			; The dots are there for branch labels. 
	lodsb
	cmp al , 0
	je .out_of_print
	call print_ch
	jmp .chk_char
.out_of_print:	
	ret
	
print_ch:	
	mov ah , 0eh
	int 0x10
	ret

msg:	db 'Hello, World!' , 10 , 0

	times 510-($-$$) db 0	
	dw 0xAA55
