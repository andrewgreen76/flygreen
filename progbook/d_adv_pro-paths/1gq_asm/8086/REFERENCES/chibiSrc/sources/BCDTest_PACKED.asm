include \SrcALL\V1_Header.asm

	call ScreenInit
	
;First let's check the state of all our registers	
	
	mov ax, @code
	mov ds, ax
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	
	mov si,TestBCD1			;Source BCD
	mov bl,4				;BCD Bytes
	call BCD_Show			;Show BL bytes of SI
	call NewLineBCD
	
	mov si,TestBCD_CP		;Source BCD
	mov bl,4				;BCD Bytes
	call BCD_Show			;Show BL bytes of SI
	call NewLineBCD
	
	
	mov si,TestBCD1			;Source BCD
	mov di,TestBCD_CP		;Dest BCD
	mov bl,4				;BCD Bytes
	call BCD_Cp				;CMP SI,DI (BL Bytes)
	jnz showNZ
	jz showZ
rz:
	pushf
		call NewLineBCD
	popf
	jnc showNC
	jc showC
rc:
	
	call NewLineBCD
	call NewLineBCD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	mov bh,4
AddAgain:	
	mov si,TestBCDAdd		;Source BCD
	mov di,TestBCD1			;Dest BCD
	mov bl,4				;BCD Bytes
	call BCD_Add			;ADD BL bytes from SI to DI

	push bx
		mov si,TestBCD1		;Source BCD
		mov bl,4			;BCD Bytes
		call BCD_Show		;Show BL bytes of SI
		call NewLineBCD
	pop bx
	
	dec bh
	jnz AddAgain
	
	call NewLineBCD
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
			
	mov bh,4
SubAgain:	
	mov si,TestBCDAdd		;Source BCD
	mov di,TestBCD1			;Dest BCD
	mov bl,4				;BCD Bytes
	call BCD_Sub			;SUB BL bytes from SI to DI

	push bx
		mov si,TestBCD1		;Source BCD
		mov bl,4			;BCD Bytes
		call BCD_Show		;Show BL bytes of SI
		call NewLineBCD
	pop bx
	
	dec bh
	jnz SubAgain
	
	call NewLineBCD
	
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 

BCD_Cp:
	xor bh,bh			;bh=0
	add si,bx			;Move to end of BCD block
	add di,bx			;Move to end of BCD block
BCD_CpB:	
	dec si
	dec di
	mov al,[si]			;Compare the two
	cmp al,[di]
	jne BCD_CpDone		;Found mismatch
	dec bl
	jne BCD_CpB
BCD_CpDone:	
	ret
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
BCD_Show:
	xor bh,bh			;bh=0
	add si,bx			;Move to end of BCD block
ShowBCDB:	
	dec si
	
	mov al,[si]
	mov cl,4
	shr al,cl
	call PrintCharBCD0	;H Nibble (Digit)
	
	mov al,[si]
	and al,00001111b
	call PrintCharBCD0  ;L Nibble (Digit)
	
	dec bl
	jne ShowBCDB
	ret
	
PrintCharBCD0:
	add al,'0'			;Convert to Ascii
	
PrintCharBCD:
	push bx
	push ds
		mov bx, @data
		mov ds, bx
		call PrintChar
	pop ds
	pop bx
	ret	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
	
BCD_Add:
	clc
BCD_Add2:
	mov al,[di]			;Add a BCD byte
	adc al,[si]
	daa					;Fix BCD Values
	mov [di],al			;Write back
	inc si
	inc di
	
	dec bl
	jne BCD_Add2		;Next Byte
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
	
BCD_Sub:
	clc
BCD_Sub2:
	mov al,[di]			;Sub a BCD byte
	sbb al,[si]
	das					;Fix BCD Values
	mov [di],al			;Write back
	inc si
	inc di
	
	dec bl
	jne BCD_Sub2		;Next Byte
	ret	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
	
NewLineBCD:
	push bx
	push ds
		mov bx, @data
		mov ds, bx
		call NewLine
	pop ds
	pop bx
	ret	
		
	
DoMonitorAX:				;Show AX To the screen
	push ds
	push bx
	push ax
		mov bx, @data
		mov ds, bx
	
		mov bx,ax
		mov al,'A'
DoMonitorNX:
		call DoMonitorOneX	;Function in the Monitor - shows [AL]X:BX
	pop ax
	pop bx
	pop ds
	ret
	
DoMonitorBX:				;Show AX To the screen
	push bx
	push ax
		mov al,'B'
		jmp DoMonitorNX

	
showNZ:
	pushf
		mov al,'N'
		call PrintCharBCD
		jmp showZB 
showZ:
	pushf
showZB:
		mov al,'Z'
		call PrintCharBCD
	popf
	jmp rz
	
showNC:
	pushf
		mov al,'N'
		call PrintCharBCD
		jmp showCB
showC:
	pushf
showCB:
		mov al,'C'
		call PrintCharBCD
	popf
	jmp rc
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	
	;packed BCD - 8 digits
TestBCD1:
	db 97h,09h,00h,10h	;10000997
	
TestBCDAdd:	
	db 04h,01h,00h,00h	;00000104

TestBCD_CP:
	db 85h,09h,00h,00h	;00000985

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

