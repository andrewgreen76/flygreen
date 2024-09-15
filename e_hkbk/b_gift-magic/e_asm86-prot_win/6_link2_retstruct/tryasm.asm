
	global _my_asm

	section .text 	
_my_asm:

	push ebp		; SP is moved automatically 
	mov ebp , esp   ; BP -> SP -> 
	
	mov eax, 54321
	mov edx, 'ABCD'	; edx is an extension of eax when returning large data like structs. 
						; edx cap is 32 bits => allows for up to 4 bytes of content 
	;mov ecx, 'M'

	pop ebp		; SP is moved automatically 
	ret