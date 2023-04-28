
    .model small
    .stack 1024
	.data

MonitorBak_AX 	dw 0
MonitorBak_F  	dw 0
MonitorBak_IP 	dw 0
MonitorBak_ES 	dw 0
MonitorBak_DS 	dw 0
	
	.code
	
	mov ax, @data		;ES points to our Data segment
	mov ds, ax
	
	mov ax, @code		;DS points to our Code segment
    mov es, ax
	
	mov ah,0h		;Set Video mode
	mov al,0		;Mode 0 (40x25 monocrome)
	int 10h 
Again:	
	mov ah,02h		;Position cursor
	mov bh,0		;page
	mov dx,0000h	;YYXX screenpos
	int 10h 
	 
	 
	call ReadCursors
	
	Call DoMonitor		;Show Registers
	
	mov bx,0F000h
Delay:
	dec bx
	nop
	nop
	nop
	nop
	jnz Delay
	jmp Again
	
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
	ret


	
	

PrintString:	;Print 255 terminated strings
	mov al,[ds:si]		;Load a letter
	cmp al,255			;CHR=255 ?
	jz PrintString_Done	;Yes? then RET
	call PrintChar		;Print to screen
	inc si				;Next Char
	jmp PrintString		;Repeat
PrintString_Done:
	ret	

PrintChar:		;Print AL to screen
	push dx
	push ax
		mov	ah, 02h	;Output character to monitor (DL)
		mov	dl, al
		int	21h		;Dos Int
	pop ax
	pop dx
	ret


PrintSpace:		;Print Space to screen
	push dx
	push ax
		mov	ah, 02h ;Output character to monitor (DL)
		mov	dl, ' '
		int	21h		;Dos Int
	pop ax
	pop dx
	ret
	
NewLine:		;Start New Line
	push dx
	push ax
		mov	ah, 02h	;Output character to monitor (DL)
		mov	dl, 13	;CR
		int	21h		;Dos Int
		mov	dl, 10	;NL
		int	21h		;Dos Int
	pop ax
	pop dx
	ret

;Include the monitor tools	
	
	include \SrcAll\V1_Monitor.asm	
	
	