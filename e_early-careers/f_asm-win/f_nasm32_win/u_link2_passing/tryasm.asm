
	global _my_asm

	section .text 	
_my_asm:

	push ebp		
	mov ebp , esp   

	mov eax, [esp+9]	; esp+8 - 1st byte of struct test 't' 
						; esp+9 - 2nd byte of struct test 't' , etc.  
	pop ebp		
	ret

	; POST-PROLOGUE TAKEAWAYS : 
	;  . [esp] = caller EBP 
	;  . [esp+4] = caller_ret_addr
	;  . [esp+8] = 1st parameter 
	;  . [esp+12] = 2nd parameter , ... 