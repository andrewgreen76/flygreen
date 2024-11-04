
	;; takes the backseat in the order of generation , compiling/linking , and execution : 
	section .asm  		

	extern int21h_handler 	; make the C func known to the .asm src file 
	global idt_load
	global int21h 		; make the ASM routine global/known to the C src file 
	
idt_load:
	push ebp
	mov ebp , esp

	mov ebx , [ebp+8]    	; 1st param , ... remember ? 
				; [ebp+4] = return address in the higher routine
	lidt[ebx]
	
	pop ebp
	ret

;;; Weaving in and out assembly just to ensure the atomicity of the int handler : ;;;;;;;;;;
int21h:
	cli 			; same for interrupts - atomic kernel op 
	pushad 			; saves values in all gen.regs
	call int21h_handler
	popad 			; restores old values in gen.regs 
	sti
	iret
