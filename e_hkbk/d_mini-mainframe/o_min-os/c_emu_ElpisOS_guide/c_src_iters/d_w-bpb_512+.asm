
	ORG 0			; Directives do not make parts of code. 
	BITS 16			; They are excluded in the final binary image and are not part of code.
				; They are just there to tell the assembler how to assemble code. 
_start:
	jmp short start 	; Byte 0 ; 3C = Byte 1
	;; The two instructions that follow are really there to pad BPB : 
	nop 			; Byte 2 - HAS TO BE `nop` per BPB/BIOS requirements. 
	times 33 db 0 		; These bytes must be allocated , but they are there for the BIOS , not us. 
				;;;;;;;;;;;;;;;;;;;;;;;;; THIS TAKES CARE OF THE BPB IN THE FACE OF BIOS. 
start:
	jmp 0x07c0:step2 	; A hack of sorts : force-sets CS to 0x07c0 and allows us to proceed. 

step2:	
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
