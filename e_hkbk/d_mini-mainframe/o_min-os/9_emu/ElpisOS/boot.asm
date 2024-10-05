
	ORG 0
	BITS 16
			 
_start:
	jmp short ld_btld
	nop
	times 33 db 0

ld_btld:
	jmp 0x07c0:find_n_ld

find_n_ld:
	cli
	mov ax, 0x07c0
	mov ds, ax
	mov es, ax
	mov ax, 0x00
	mov ss, ax
	mov sp, 0x7c00
	sti

	mov ah, 2
	mov al, 1
	mov bx, destbuf
	mov ch, 0
	mov cl, 2

	mov dh, 0

	int 0x13

	jc print_err
	jmp $

print_err:
	mov si , errmsg
	call print_msg

	jmp $

print_msg:
	mov ah , 0eh
.chk_char:
	lodsb
	cmp al, 0
	je .out
	int 0x10
	jmp .chk_char
.out:
	ret

errmsg:	db 'Failed to load sector', 0

	times 510-($-$$) db 0
	dw 0xAA55

destbuf:
