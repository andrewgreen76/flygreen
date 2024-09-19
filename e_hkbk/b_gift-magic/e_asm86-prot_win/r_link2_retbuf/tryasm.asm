
	global _my_asm

	section .text 	
_my_asm:

					; [30B buf] [18B : 4B buf_addr] (no_para) [ret_addr] ESP
	push ebp		; [30B buf] [18B : 4B buf_addr] (no_para) [ret_addr] [caller EBP] ESP
	mov ebp , esp   

	;;;;;;;; Let's say we want to : deref 1st byte of buf , write 'A' to it. ;;;;;;;;
	; mov byte [esp+8] , 'A' 	; Won't work. [esp+8] is buf_addr. 
								; We don't want to overwrite buf_addr. We want to OVERWRITE DATA. 
	mov eax , [ebp+8]			; [EBP] >>> [ret_addr] >>> load [buf_addr] , ret to struct test s. 
	mov byte [eax] , 'A'		; deref buf_addr 
	
	pop ebp		; SP is moved automatically 
	ret

	; POST-PROLOGUE TAKEAWAYS : 
	;  . [esp] = caller EBP 
	;  . [esp+4] = caller_ret_addr
	;  . [esp+8] = 1st parameter 
	;  . [esp+12] = 2nd parameter , ... 