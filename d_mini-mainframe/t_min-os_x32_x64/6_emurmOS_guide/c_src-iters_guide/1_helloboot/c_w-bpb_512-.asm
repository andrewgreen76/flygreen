
	ORG 0			 
	BITS 16			
				 
_start:
	jmp short start 	 
	nop 			 
	times 33 db 0 		
				
start:
	jmp 0x07c0:step2 	 

step2:	
	cli			
	mov ax , 0x07c0	 	 
	
	mov ds , ax 		 
	mov es , ax 		
				
	mov ax , 0x00
	mov ss , ax
	mov sp , 0x7c00 	
	sti			
	
	mov si , msg
	call print_msg 
	jmp $			

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

msg:	db 'Hello, World!' , 10 , 0

	times 510-($-$$) db 0	
	dw 0xAA55
