	
section .bss 
	
section	.data
lmsg db "Below" , 10
emsg db "Equal" , 10
gmsg db "Above" , 10
mlen equ 6
	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
section	.text
	global _start 
_start:
	;; DIRECT IN-FILE NUM.INPUT
	mov eax, 2
	cmp eax, 3
	jl  below
	je  equal
	jg  above 

below:	; PRINT IF BELOW
	mov	eax, 4		; system call number (sys_write)
	mov	ebx, 1		; file descriptor (stdout)
	mov	ecx, lmsg	; address of stream buffer 
	mov	edx, mlen	; buffer length
	int	0x80		; call kernel
	jmp 	anycase
	
equal:	; PRINT IF EQUAL
	mov	eax, 4		; system call number (sys_write)
	mov	ebx, 1		; file descriptor (stdout)
	mov	ecx, emsg	; address of stream buffer 
	mov	edx, mlen	; buffer length
	int	0x80		; call kernel
	jmp 	anycase 

above:	; PRINT IF ABOVE
	mov	eax, 4		; system call number (sys_write)
	mov	ebx, 1		; file descriptor (stdout)
	mov	ecx, gmsg	; address of stream buffer 
	mov	edx, mlen	; buffer length
	int	0x80		; call kernel

anycase:
	;; EXIT 
	mov	eax, 1		; system call number (sys_exit)
	xor 	ebx, ebx	; return code 0 if no bugs encountered  
	int	0x80		; call kernel


