
section .bss 
	
section	.data
buflen 	equ 5
stars  	times buflen - 1 db '*'
	db 10
	;; alternatively :
	;; buffer db msglen dup('*')
	
section	.text
global _start 
	
_start:                 	
	mov	edx, buflen	; buffer length
	mov	ecx, stars	; address of stream buffer 
	mov	ebx, 1		; file descriptor (stdout)
	mov	eax, 4		; system call number (sys_write)
	int	0x80		; call kernel

	mov	eax, 1		; system call number (sys_exit)
	int	0x80		; call kernel


