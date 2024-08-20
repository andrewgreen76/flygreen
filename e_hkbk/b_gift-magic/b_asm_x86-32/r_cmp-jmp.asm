	
section .bss 
	
section	.data
ltmsg db "Smaller" , 10
eqmsg db "Equal" , 10
gtmsg db "Larger" , 10
msglen equ 8
	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
section	.text
	global _start 
_start:
	;; DIRECT IN-FILE NUM.INPUT
	mov eax, 2
	cmp eax, 3
	jl  less_than
	je  equal_to
	jg  greater_than

less_than:	; PRINT IF BELOW
	mov	eax, 4		; system call number (sys_write)
	mov	ebx, 1		; file descriptor (stdout)
	mov	ecx, ltmsg	; address of stream buffer 
	mov	edx, msglen	; buffer length
	int	0x80		; call kernel
	jmp 	done_cmp
	
equal_to:	; PRINT IF EQUAL
	mov	eax, 4		; system call number (sys_write)
	mov	ebx, 1		; file descriptor (stdout)
	mov	ecx, eqmsg	; address of stream buffer 
	mov	edx, msglen	; buffer length
	int	0x80		; call kernel
	jmp 	done_cmp

greater_than:	; PRINT IF ABOVE
	mov	eax, 4		; system call number (sys_write)
	mov	ebx, 1		; file descriptor (stdout)
	mov	ecx, gtmsg	; address of stream buffer 
	mov	edx, msglen	; buffer length
	int	0x80		; call kernel

done_cmp:
	;; EXIT 
	mov	eax, 1		; system call number (sys_exit)
	xor 	ebx, ebx	; return code 0 if no bugs encountered  
	int	0x80		; call kernel


