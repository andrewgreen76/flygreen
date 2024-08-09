
section .bss 
	
section	.data
buflen 	equ 5
bufaddr db buflen-1 dup('*')
	db 10

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
section	.text
	global _start 
_start:                 	
	mov	edx, buflen	; buffer length
	mov	ecx, bufaddr	; address of stream buffer 
	mov	ebx, 1		; file descriptor (stdout)
	mov	eax, 4		; system call number (sys_write)
	int	0x80		; call kernel

	mov	eax, 1		; system call number (sys_exit)
	int	0x80		; call kernel


