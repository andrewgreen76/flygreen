
	org 100h

	mov al , 'A'		; input 
	out 130 , al		; peripheral data port for output (130 is for the printer) 

	ret 
