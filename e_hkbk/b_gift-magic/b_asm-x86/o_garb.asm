
section .data
	dig_addr db 5
	null db 0
	newline db 10
	outbuf db 0 , 0

section .text
	global _start

_start:
	xor eax, eax
	mov al, dig_addr
	add al , '0'

    ; Exit the program
	mov eax, 1      ; sys_exit system call number
	xor ebx, ebx    ; Exit status (0 for success)
	int 0x80        ; Call kernel 
