
	ORG 0
	BITS 16			

start:
	cli			; clear interrupts

	mov ax , 0x7c0
	mov ds , ax
	mov es , ax 
	
	sti			; enable interrupts
	mov si , msg
	call print_msg 
	jmp $			; "halting" point

print_msg:
	mov ah , 0eh
.chk_char:			; The dots are there for branch labels. 
	lodsb
	cmp al , 0
	je .out			; Halt or not ?
	int 0x10		; print char 
	jmp .chk_char		; read next char 
.out:
	ret

msg:	db 'Hello, World!' , 10 , 0

	times 510-($-$$) db 0	
	dw 0xAA55
