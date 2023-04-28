
    .model small
    .stack 1024
	.data
TxtHello		db "Hello world!",255

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
	
	
	mov si,offset TxtHello
	call PrintString	;Show DS:SI to screen 
	
	DEC AL        
	DEC AX        
	DEC Byte ptr [1000h]
	
	Call DoMonitor		;Show Registers
	
	sub al,1
	aas
	
	Call DoMonitor		;Show Registers
	
	
	mov bp,PrintString	;Address to show
	mov bx,16			;Bytes to show
	call MemDump
		
	
	call NewLine
	
	
inf:	
	jmp inf
	

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
	
	