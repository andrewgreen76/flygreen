
ReadJoystick:
	push bx
	push cx
	push dx

		mov dx,201h		;baBAyxYX	;BA=Joy 1 Fires
							; XY= Joy 1 direction bit.
						
		in al,dx			;Read in Fire buttons
		push ax
			mov al,255		;Strobe the port 
			out dx,al
		
			mov bx,0		;Xpos Joy 1
			mov cx,0		;Ypos Joy 1
ReadJoyAgainD:	
			in al,dx
			and al,00000011b
			jz JoyDirsDoneD
			push ax
				and al,00000001b;X axis
				jz JoyNotXD
				inc bx			;Inc Xpos
JoyNotXD:
			pop ax
			and al,00000010b	;Y axis
			jz JoyNotYD
			inc cx				;Inc Ypos
JoyNotYD:
			jmp ReadJoyAgainD
JoyDirsDoneD:	
		pop ax				;Get back fire buttons
		
		cmp bx,64
		jc JoyDLeft
		or al,00000100b
JoyDLeft:
		cmp bx,300-64
		jnc JoyDRight
		or al,00001000b
JoyDRight:
		cmp cx,64
		jc JoyDUp
		or al,00000001b
JoyDUp:
		cmp cx,300-64
		jnc JoyDDown
		or al,00000010b
JoyDDown:
		mov ah,255
		mov dx,ax
		call ReadCursors
		and ax,dx
		
		
	pop dx
	pop cx
	pop bx
	ret
	
	

;Take any waiting keys off the buffer (not returned - AX unchanged)
ReadCursors:	;Ah=[Shifts] AL=0b--ESRLDU read Cursors/Enter/Space and shifts
	mov bx,0
ReadCursorsAgain:
	mov	ah, 01h	;See if buffer not empty
	int	16h		
	jz ReadCursorsDone

	mov	ah, 00h	;Read a key
	int	16h		
	
	cmp ah,48h		;Compare to UP
	jnz CurNotUp
	or bl,00000001b
CurNotUp:	
	cmp ah,50h		;Compare to Down
	jnz CurNotDown
	or bl,00000010b
CurNotDown:	
	cmp ah,4Bh		;Compare to Left
	jnz CurNotLeft
	or bl,00000100b
CurNotLeft:	
	cmp ah,4Dh		;Compare to Right
	jnz CurNotRight
	or bl,00001000b
CurNotRight:	
	cmp ah,39h		;Compare to Space
	jnz CurNotSpace
	or bl,00010000b
CurNotSpace:	
	cmp ah,1ch		;Compare to Enter
	jnz CurNotEnter
	or bl,00100000b
CurNotEnter:	

	jmp ReadCursorsAgain
	
ReadCursorsDone:
	push bx
		mov	ah, 02h	;Test Keyboard AT Control/Shift Keys (result in AX)
		int	16h		;Keyboard Interrupt	
		mov bx,ax
	pop ax
	mov ah,bl
	xor ax,0FFFFh
	ret
	