
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
	
;Turn on the mouse	
	mov ax,0		;Reset Mouse
	int 33h
	
	mov ax,1		;Display Mouse
	int 33h
	
	;mov ax,2		;Hide Mouse again
	;int 33h
	

;Set the mouse  Cursor Range
	
	;mov cx,64		;Min-X
	;mov dx,320		;Max-X
	;mov ax,7		;Set Mouse Range H (0-640)
	;int 33h	
	
	;mov cx,32		;Min-Y
	;mov dx,100		;Max-Y
	;mov ax,8		;Set Mouse Range V (0-200)
	;int 33h	
	
	mov cx,128		;Xpos
	mov dx,64		;Ypos
	mov ax,4		;Move Cursor
	int 33h	
	
;Mouse co-ordinates are mesured in 'mickeys' 
	;because apparently someone thought that was funny! 
	
;Default speed is 8x16 mickeys
	
	mov cx,8*1		;X Speed (Lower=Faster)
	mov dx,16*1		;Y Speed (Lower=Faster)
	mov ax,0Fh		;Set speed
	int 33h	
	
	
	
Again:	

	mov ah,02h		;Position cursor
	mov bh,0		;page
	mov dx,0000h	;YYXX screenpos
	int 10h 		;Move cursor to top of screen
	 
;Read the position of the cursor
	mov ax,3		;Read Mouse (CX=X DX=Y)
	int 33h				;Buttons in BL=0b-----CRL
	
	Call DoMonitor

	mov bx,0
	
;Read the relative movement of the cursor
	
	mov ax,0Bh		;Determine Relative movement
	int 33h			;CX=Horiz DX=Vert...
						;Buttons not read
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
	
	