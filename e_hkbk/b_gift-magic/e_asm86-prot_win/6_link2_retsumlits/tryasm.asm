
	global _my_asm

	section .text 	
_my_asm:

	push ebp		; SP is moved automatically 
	mov ebp , esp   ; BP -> SP -> 

	;;  Creating a local scope : 
	sub esp, 8    	; create a gap for two local ints ( sizeof(int) = 4 bytes ) 

	mov dword[ebp-4], 30    ; byte = 8 bits @@@ word = 2 bytes = 16 bits @@@ dword = 4 bytes = 32 bits
							; go to EBP-4, populate double-word (4 bytes) , 
							; initialize that memory piece with num 30. 
	mov dword[ebp-8], 80
	mov eax, dword[ebp-4]
	add eax, dword[ebp-8]

	;; Closing the local scope : 
	add esp, 8  ; wind down , forget all vars 

	pop ebp		; SP is moved automatically 
	ret

	; Notice the presence of '4' in the instructions. This is called memory alignment: In 32-bit 
	;   systems all offsets should be multiples of 4 , even for data that could easily fit into 
	;   3, 2, or even 1 byte. Otherwise , the integrity of the stack frame is violated and we have 
	;   corrupted memory on our hands. Therefore , using 'dword[]' instead of 'word[]' and 'byte[]' 
	;   is also preferrable. 
	
	; Also , notice that we do [ebp + offset] to access arguments and we do [ebp - offset] to access 
	;   local variables/structures/objects. Don't forget to account for the caller's return address 
	;   and the caller's base address pushed under arguments. 
