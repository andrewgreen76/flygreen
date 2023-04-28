;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
    .model small	;Tell Assembler Memory Model to use
	
    .stack 1024			;Stack pointer area
	
;Data Segment (DS)
	.data				
TxtHello		db "Hello world!",255
	
;Code Segment (CS)
	.code
	
	mov ax, @data		;ES points to our Data segment
	mov ds, ax
	
	mov ax, @code		;DS points to our Code segment
    mov es, ax
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	mov si,offset TxtHello ;Address of Hello World string 
	call PrintString	;Show DS:SI to screen 
	
	call NewLine
	
	mov	ah, 4ch			;Terminate a process (EXIT)
	mov	al, 0			;Return Code 
	int	21h				;Dos Int


PrintString:	;Print 255 terminated string from [ds:si]
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
		mov	dl, al	;DL = Character to print
		int	21h		;Dos Int
	pop ax
	pop dx
	ret
	
NewLine:		;Start New Line
	push dx
	push ax
		mov	ah, 02h	;Output character to monitor (DL)
		mov	dl, 13	;CR - Carriage return
		int	21h		;Dos Int
		mov	dl, 10	;NL - New Line
		int	21h		;Dos Int
	pop ax
	pop dx
	ret