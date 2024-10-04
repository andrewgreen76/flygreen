
	ORG 0			 
	BITS 16			
				 
_start:
	jmp short ld_btld
	nop 			 
	times 33 db 0 	; Faked all {0x03 -> 0x35} data bytes for BPB / 512. 

ld_btld:
	jmp 0x07c0:find_n_ld ; Manual load of CS:IP. 

hndl_int0:		; an ISR : prints 'A'  
	mov ah , 0eh
	mov al , 'A'
	mov bx , 0
	int 0x10
	iret 		; end of ISR 

hndl_int1:
	mov ah , 0eh
	mov al , 'V'
	mov bx , 0
	int 0x10
	iret
	
find_n_ld:	
	cli			
	mov ax , 0x07c0	 	 
	mov ds , ax 	; DS = 0x7C00
	mov es , ax	; ES = -//-
	mov ax , 0x00
	mov ss , ax	; SS:0 is RAM:0
	mov sp , 0x7c00 	
	sti			
	;;; MAPPING ADDRESSES OF CUSTOM INTS TO MAKE IVT ;;;;;;;;;;;;;
				   ; 0x0 = IVT , not the boot code. 
	mov word[ss:0] , hndl_int0 ; addr_isr0 = SS = 0 = RAM:0 = int0_offset   ;   Otherwise , if [0] => [DS:0] => 0x7C00 + 0 = 0x7C00
	mov word[ss:2] , 0x07C0    ; RAM:2 = int0_seg = CS:

	mov word[ss:4] , hndl_int1 ; RAM:3 = int1_off = :IP
	mov word[ss:6] , 0x07C0	   ; RAM:4 = int1_seg = CS:

	;;; PROGRAMMING LOGIC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; mov ax , 0		; Prints 'A'.
	;; div ax		; CPU is designed to automatically generate the `int 0` exception upon DIV/0 (no matter what).
	;; int 1		; Prints 'V'. 
	
	mov si , msg 		; Print "Hello, World!"
	call print_msg 
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

msg:	db 'Hello, World!' , 10 , 0

	times 510-($-$$) db 0	
	dw 0xAA55
