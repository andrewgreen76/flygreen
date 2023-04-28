

	cmp ah, 48h		; ah - 48h
	jg CurNotUp		; jump if ah > 48h
	jl
	jge
	jle
	jnz CurNotUp	; jump if ah - 48h =/= 0 
	jz CurNotUp		; jump if ah - 48h =0 
	
	
	
	;mov al, [DS:SI] 
	xor al, [ES:DI] 	; If bits are different (screen is blank), show bits. 
						; If bits are the same (having been written in), erase bits. 
	;mov [ES:DI], al
	
	
	
	add bx, ax		; bx = bx + ax
	
	
	
	sub bx, ax		; bx = bx - ax
	
	
	
	mul bx			; AX = bx * ax 
	
	
	
	