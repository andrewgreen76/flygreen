
	section .asm

	global insb

insb:
	push ebp
	mov ebp , esp

	mov edx , [ebp+8]    	; 1st param 

	pop ebp
	ret
