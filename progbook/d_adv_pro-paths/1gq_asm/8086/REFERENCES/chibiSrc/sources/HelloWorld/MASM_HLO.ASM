;Text after semicolon is comments, you don't need to type it in

    .model small		;Tell Assembler Memory Model to use
	
    .stack 1024			;Stack pointer area (1024 bytes)
	
;Data Segment (DS)
	.data				
TxtHello		db "Hello world!",255

;Code Segment (CS)
	.code
	mov ax, @data		;DS points to our Data segment
	mov ds, ax
	
	mov si,offset TxtHello ;Address of Hello World string 
	call PrintString	;Show DS:SI to screen 
	
	mov	ah, 4Ch			;Terminate a process (EXIT)
	mov	al, 0			;Return Code 
	int	21h				;Dos Int

PrintString:	;Print 255 terminated string from [ds:si]
	mov al,ds:[si]		;Load a letter
	cmp al,255			;CHR=255 ?
	jz PrintString_Done	;Yes? then RET
	call PrintChar		;Print to screen
	inc si				;Next Char
	jmp PrintString		;Repeat
PrintString_Done:
	ret	

PrintChar:				;Print AL to screen
	mov	ah, 02h			;Output character to monitor (DL)
	mov	dl, al			;DL = Character to print
	int	21h				;Dos Int
	ret
END
	
	
	
