
	ORG 0			; REMEMBER: THIS IS JUST AN OFFSET IN QEMU MACHINE'S RAM 
	BITS 16			; HOWEVER , BIOS WILL LOAD 0x07C0:0x0000 INTO CS:IP ALL
				; BY ITSELF !

start:
	cli			; clear the int flag in FLAGS (disable interrupts)
	;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax , 0x07c0	 	; This method is an alternative to ORG 0x7C00. 
	
	mov ds , ax 		; DS:SI starting address calibrated to 0x7c00. Source buffer offsets are taken care of. 
	mov es , ax 		; ES:DI starting address calibrated to 0x7c00. Destination buffer offsets are taken care of.
				; Data is part of our source code within the same segment @ 0x7C00.

	mov ax , 0x00
	mov ss , ax
	mov sp , 0x7c00 	; Keep in mind : this is a pointer register , not a segment register.
	;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
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
