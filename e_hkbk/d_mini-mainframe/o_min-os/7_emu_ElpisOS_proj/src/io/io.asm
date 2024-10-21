
	section .asm

	global insb

insb:
	push ebp
	mov ebp , esp

	mov edx , [ebx+8]

	pop ebp
	ret
