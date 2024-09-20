
	global _my_asm

	section .text 	
_my_asm:
					; [_start &ret] [_start BP] BP [ &50 50 ____ &50 ] [main &ret] SP
	push ebp		; [_start &ret] [_start BP] BP [ &50 50 ____ &50 ] [main &ret] [main BP] SP
	mov ebp , esp   ; [_start &ret] [_start BP] [ &50 50 ____ &50 ] [main &ret] [main BP] BP/SP

	mov eax, [esp+8]	; load param &50 
	mov eax, [eax]		; deref param &50 ; will print '50'. 
	
	pop ebp		; SP is moved automatically 
	ret

	; POST-PROLOGUE TAKEAWAYS : 
	;  . [esp] = caller EBP 
	;  . [esp+4] = caller_ret_addr
	;  . [esp+8] = 1st parameter 
	;  . [esp+12] = 2nd parameter , ... 