	section .asm

	global idt_load
	
idt_load:
	push ebp
	mov ebp , esp

	mov ebx , [ebp+8]    	; 1st param , ... remember ? 
				; [ebp+4] = return address in the higher routine
	lidt[ebx]
	
	pop ebp
	ret
