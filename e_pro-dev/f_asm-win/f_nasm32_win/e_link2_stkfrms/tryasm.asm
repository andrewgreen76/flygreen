
	global _my_asm

	section .text 	
_my_asm:
	push ebp
	mov ebp , esp

	mov eax , [ebp+12] ; yields 10 , [ebp+8] yields 5

	pop ebp
	ret