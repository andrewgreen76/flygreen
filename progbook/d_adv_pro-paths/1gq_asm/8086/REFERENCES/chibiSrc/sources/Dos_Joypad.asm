
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
	mov al,4		;Mode 1
	int 10h 
	
	jmp DirectTest		;Read in direct from the hardware
	
	
	;Function 84h= Hoystick Reader DX=0 read Fires DX=1 Read Dirs
	
Again:	
	mov ah,02h		;Position cursor
	mov bh,0		;page
	mov dx,0000h	;YYXX screenpos
	int 10h 
	 
	mov ah,84h		;Read Joystick
	mov dx,0		;0=Get Switches AL= 0bAB12----b	
	int 15h				;12 1st joy . AB 2nd joy
	Call DoMonitor	
	
	mov ah,84h		;Get Directions AX,BX = Joy 1 X,Y 
	mov dx,1			;CX,DX = Joy 2 X,Y
	int 15h
	Call DoMonitor		
	
	mov bx,0F000h
Delay:
	dec bx
	nop
	nop
	nop
	nop
	jnz Delay
	
	jmp Again
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	
DirectTest:
	mov ah,02h		;Position cursor
	mov bh,0		;page
	mov dx,0000h	;YYXX screenpos
	int 10h 
	
;Can read in direct from hardware with port 201
;we need to strobe the port with a write (255) then read bits 0/1 for the X,Y position - counting how long it takes to reach zero.
;Use Bits 1/2 for Second Joystick

	mov dx,201h		;baBAyxYX	;BA=Joy 1 Fires
						; XY= Joy 1 direction bit.
					
	in al,dx			;Read in Fire buttons
	push ax
		mov al,255		;Strobe the port 
		out dx,al
	
		mov bx,0		;Xpos Joy 1
		mov cx,0		;Ypos Joy 1
ReadJoyAgain:	
		in al,dx
		and al,00000011b
		jz JoyDirsDone
		push ax
			and al,00000001b;X axis
			jz JoyNotX
			inc bx			;Inc Xpos
JoyNotX:			
		pop ax
		and al,00000010b	;Y axis
		jz JoyNotY
		inc cx				;Inc Ypos
JoyNotY:
		jmp ReadJoyAgain
JoyDirsDone:	
	pop ax				;Get back fire buttons
	
	Call DoMonitor		;Show Registers
	
	jmp DirectTest

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
	
	