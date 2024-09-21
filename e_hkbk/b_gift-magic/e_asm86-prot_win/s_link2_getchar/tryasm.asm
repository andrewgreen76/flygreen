
	global _my_asm
	extern _getchar

	section .text 	
_my_asm:

	push ebp		
	mov ebp , esp   

	call _getchar

	pop ebp		
	ret

	; POST-PROLOGUE TAKEAWAYS : 
	;  . [esp] = caller EBP 
	;  . [esp+4] = caller_ret_addr
	;  . [esp+8] = 1st parameter 
	;  . [esp+12] = 2nd parameter , ... 