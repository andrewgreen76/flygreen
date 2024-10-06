
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
	;; CHS CODE ... if you care ... seeing that it's legacy tech that's way too complicated. 
	mov ah , 2 		; (cuz int13 - disk op - and) we want to READ off of the medium 
	mov al , 1 		; read ONE SECTOR
	mov bx , stdbuf		; specify interm.buffer = dd_dest = emu_src
	mov ch , 0 		; cyl no.
	mov cl , 2 		; sector no. (NOT INDEX).
				; CHS indexing is 1-based , LBA indexing is 0-based.
	mov dh , 0 		; head no.
	;; dl is set automatically 
	int 0x13 		; disk operation 

	jc print_err 		; "The carry bit would be raised if the disk operation using interrupt
				; `0x13` fails, indicating an error such as trying to read a sector
				; that does not exist or a hardware issue with the disk."
	mov si , stdbuf
	call print_msg
	jmp $			
	
print_err:
	mov si , errmsg
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

	;;; 1st sector has the code below for populating hardcoded chars. ;;;;;;;;;;;;;

errmsg:	db 'Failed to load sector' , 0 
	
	times 510-($-$$) db 0	
	dw 0xAA55

;;; End of 1st sector (boot code). ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Start of 2nd sector (anything we want - in text). ;;;;;;;;;;;;;;;;
	
stdbuf:			; Uninit'd buffer.
			; We use `dd` to copy text file bytes to this sector of the binary boot image ;
			; the code in the 1st sector will use the 2nd sector at runtime. 
			; `dd if=/dev/zero bs=512 count=1` will zero out the memory
			; starting at this address.
