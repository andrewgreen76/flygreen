
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
	
; AH= 00,01,02... XT keyboard commands
;Alternatively
; AH= 10,11,12... AT keyboard commands (more keys - eg F12)
	
Again:	
;Get the status of the control/shift etc keys
	
	;mov	ah, 02h	;Test Keyboard XT Control/Shift Keys (result in AX)
	mov	ah, 12h	;Test Keyboard AT Control/Shift Keys (result in AX)
	int	16h		;Keyboard Interrupt	
	mov bx,ax
	
;Lets Test the keyboard buffer to see if anything is waiting (Buffer unchanged)
	
	;mov	ah, 01h	;Test Keyboard XT (Z clear if key is present)
	mov	ah, 11h	;Test Keyboard AT (Z clear if key is present)
	int	16h		;Keyboard Interrupt
	jz NoKey

;A key is waiting - lets take it off the buffer 
	
	;mov	ah, 0h	;Read Keyboard XT (take keypress from buffer AX=SSAA S=Scan A=Ascii)
	mov	ah, 10h	;Read Keyboard AT (take keypress from buffer AX=SSAA S=Scan A=Ascii)
	int	16h		;Keyboard Interrupt
	
NoKey:	
	Call DoMonitor		;Show Registers

	call ClearBuffer	;Remove any other waiting keys from the buffer
	
	
	
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
ClearBuffer:	
	push ax
ClearBuffer2:
		mov	ah, 11h	;See if buffer not empty
		int	16h		
		mov bx,ax
		jnz ClearBuffer3	;No Keys waiting Restart loop
	pop ax
	ret
ClearBuffer3:	
	mov	ah, 10h	;Key waiting - take it from buffer
	int	16h			
	jmp ClearBuffer2


	
	

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
	
	