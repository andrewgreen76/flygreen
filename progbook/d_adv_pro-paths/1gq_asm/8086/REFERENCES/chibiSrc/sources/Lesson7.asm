include \SrcALL\V1_Header.asm
	
	jmp Start
	
sourcedata:
	BYTE 001h,023h,045h,067h,089h,0ABh,0CDh,0EFh
	BYTE 012h,034h,056h,078h,09Ah,0BCh,0DEh,0F0h

searchdata:
	BYTE 33h,33h,33h,33h,22h,22h,22h,22h
	BYTE 22h,22h,22h,22h,22h,22h,11h,11h	

comparedata:
	BYTE 000h,000h,000h,000h,089h,0ABh,0CDh,0EFh
	BYTE 012h,034h,056h,078h,000h,000h,000h,000h
	
destdata:	
	BYTE 16 dup (0)			;We'll write data here in test routines (16 bytes)

xlatdata:
	BYTE 00h,11h,22h,33h,44h,55h,66h,77h
	
start:
	
	call ScreenInit
	


	;jmp TestXLAT			;Translate from a lookup table  with XLUT
	;jmp TestStringLoad		;Load a Byte or Word from ram (and inc) with LODS
	;jmp TestStringCompare	;Search for a Byte/Word with CMPS
	jmp TestStringScan		;Scan string for a byte/word 
	jmp TestStringStore		;Save strings with MOVS ,store a string of one byte/words with STOS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestXLAT:	;Translate (Read from LUT)... AL = [DS:BX+AL]

		mov bx,xlatdata	;Lookup table (in DS:BX)
		mov ax,cs		;Get Code Segment
		mov ds,ax		;String Source segment (DS:BX)
		
		mov ax,0		;Reset AX
		
		mov cx,5		;Loop count
TestXLATAgain:		
		push ax
			call DoMonitorAXBXx
			xlat 					;Translate AL (AL = [DS:BX+AL])
			call DoMonitorAXBXx		;Show Results
			call NewLinex			;Move down a line
		pop ax
		inc al
		loop TestXLATAgain			;Repeat until CX=0
	jmp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TestStringCompare:	;Search for a Byte/Word with CMPS
	call ScreenInit
	push ds
	push es
		mov cx,9		;Byte/Word Count
	
		mov ax,cs		;Get Code Segment
		
		mov ds,ax		;String Source segment (DS:SI)
		mov si,sourcedata+8	;String Source Offset
		
		mov es,ax		;String Destination segment (ES:DI)
		mov di,comparedata+8 ;String Destination Offset		
	
		mov bp,sourcedata  ;Address to show
		call ShowStringResults ;Show Test Results
	
		cld 			;Normal direction +1 after each REP
		;std			;Reverse Direction -1 after each REP
		
		repz cmpsb		;Repeatedly COMPare bytes
		;cmpsb			;Do one compare - CX unchanged
	pop es
	pop ds
	
	mov bp,comparedata	;Address to show
	call ShowStringResults ;Show Test Results
	
	jmp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestStringLoad:			;Load a Byte or Word from ram (and inc) with LODS
	push ds
	push es
		mov cx,3		;Byte/Word Count
		
		mov ax,cs		;Get Code Segment
		mov ds,ax		;String Source segment (DS:SI)
		mov si,sourcedata;String Source Offset
		
		mov bp,sourcedata	   ;Address to show
		call ShowStringResults ;Show Test Results
	
		mov ax,0		;We'll read into AX/AL
		lahf			;Zero flags
		
		cld 			;Normal direction +1 after each REP
		
		lodsb 			;Load a byte
		call ShowStringResult	;Show it
		lodsb 			;Load a byte
		call ShowStringResult	;Show it
		lodsb 			;Load a byte
		call ShowStringResult	;Show it
		
		call newlinex
		
		lodsw			;Load a Word
		call ShowStringResult	;Show it
		lodsw			;Load a Word
		call ShowStringResult	;Show it
		lodsw			;Load a Word
		call ShowStringResult	;Show it
		
	pop es
	pop ds
	
	jmp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestStringScan:			;Scan string for a byte/word 
	call ScreenInit
	push ds
	push es
		mov cx,8        ;Scan length (6=fail 8=OK)
	
		mov ax,cs		;Get Code Segment
		
		mov es,ax		;String Destination segment (ES:DI)
		mov di,searchdata+8 ;String Destination Offset		
	
		mov bp,searchdata		;Address to show
		call ShowStringResults ;Show Test Results
	
		cld 			;Normal direction +1 after each REP
		;mov ax,11h
		;repnz scasb	;Z=Scan for AL ... repeat until found or CX=0 (AKA REPNE)
		
		std			;Reverse Direction -1 after each REP
		mov ax,2222h
		repz scasw		;NZ=Scan until not AX ... repeat until found or CX=0 (AKA REPE)
		
	pop es
	pop ds
	mov bp,searchdata			;Address to show

	call ShowStringResults
	
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestStringStore:	;Save strings with MOVS ,store a string of one byte/words with STOS
	call ScreenInit
	push ds
	push es
		mov ax,cs		;Get Code Segment
		
		mov ds,ax		;String Source segment (DS:SI)
		mov si,sourcedata+8	;String Source Offset
		
		mov es,ax		;String Destination segment (ES:DI)
		mov di,destdata+8 ;String Destination Offset		
			
		mov cx,3		;Byte/Word Count
		mov bp,sourcedata		;Address to show
		call ShowStringResults ;Show Test Results
	
		cld 			;Normal direction +1 after each REP
		;std			;Reverse Direction -1 after each REP
		
		;rep movsw		;REPeatedly MOVe String cx Words from DS:SI to ES:DI 
		;rep movsb		;REPeatedly MOVe String cx Bytes
		
		;mov ax,1122h		
		;rep stosw		;REPeatedly STOre cx times ax to ES:DI 
		;rep stosb		;REPeatedly STOre cx times al to ES:DI 
	pop es
	pop ds
	mov bp,destdata			;Address to show
	call ShowStringResults ;Show Test Results
	
	jmp $
	
	
	
	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NewLinex:
	pushf
	push ds
		push dx
				mov dx, @data		;ES points to our Data segment
				mov ds, dx
		pop dx
		call NewLine	
	pop ds
	popf 
	ret
DoMonitorAXBXx:				;Show AX+BX To the screen	
	push ds
		push dx
				mov dx, @data		;ES points to our Data segment
				mov ds, dx
		pop dx
		call DoMonitorAX
		call DoMonitorBX
		call DoMonitorCX
		call NewLine	
	pop ds
	ret	
ShowStringResult:
	pushf
	push ds
		push ax
			mov ax, @data		;ES points to our Data segment
			mov ds, ax
		pop ax
		call DoMonitorFlags
		call DoMonitorSIDI
	pop ds
	popf
	ret

ShowStringResults:
	pushf
	push ds
		push ax
			mov ax, @data		;ES points to our Data segment
			mov ds, ax
		pop ax
		call DoMonitorFlags
		call DoMonitorSIDI
		
		mov bx,16				;Bytes to show
		call MemDump
		call newline
	pop ds
	popf
	ret
DoMonitorFlags:
	push ax	
		pushf
			mov ah,'-'
			mov al,ah
			jnc DoMonitorFlagsNC	;C=Carry
			mov al,'C'
DoMonitorFlagsNC:
			call printchar 
		popf
		pushf
			mov al,ah
			jnp DoMonitorFlagsNP	;P=parity (P=even)
			mov al,'P'
DoMonitorFlagsNP:
			call printchar 
		popf
		pushf
			mov al,ah
			jnz DoMonitorFlagsNZ	;Z=zero
			mov al,'Z'
DoMonitorFlagsNZ:
			call printchar 
		popf
		pushf
			mov al,ah
			jns DoMonitorFlagsNS	;Sign (S=negative)
			mov al,'S'
DoMonitorFlagsNS:
			call printchar 
		popf
		pushf
			mov al,ah
			jno DoMonitorFlagsNO	;Overflow(0=Sign flipped)
			mov al,'O'
DoMonitorFlagsNO:
			call printchar 
		popf
		pushf
		pop ax
		push ax	;  FEDCBA9876543210
			and ax,0000001000000000b
			mov al,'-'
			jz DoMonitorFlagsNI	;Overflow(0=Sign flipped)
			mov al,'I'
DoMonitorFlagsNI:
			call printchar 
		popf
		pushf
		pop ax
		push ax	;  FEDCBA9876543210
			and ax,0000010000000000b
			mov al,'-'
			jz DoMonitorFlagsND	;Overflow(0=Sign flipped)
			mov al,'D'
DoMonitorFlagsND:
			call printchar 
		popf
		
		pushf	
			mov al,' '
			call printchar 
		popf
	pop ax
	ret
	
DoMonitorAXBXBPDI:
	call DoMonitorAX
	call DoMonitorBX
	push bx
	push ax
		mov ax,'PB'
		mov bx,bp
		call DoMonitorOne
		
		mov ax,'ID'
		mov bx,di
		call DoMonitorOne
	pop ax
	pop bx
	call NewLine	
	ret

DoMonitorAXBX:				;Show AX+BX To the screen	
	call DoMonitorAX
	call DoMonitorBX
	call NewLine	
	ret
	
DoMonitorAX:				;Show AX To the screen
	push bx
	push ax
		mov bx,ax
		mov al,'A'
DoMonitorNX:
		call DoMonitorOneX	;Function in the Monitor - shows [AL]X:BX
	pop ax
	pop bx
	ret
DoMonitorSIDI:				;Show AX To the screen
	call DoMonitorAX
	push bx
	push ax	
		mov ax,'IS'
		mov bx,SI
		call DoMonitorOne
		mov ax,'ID'
		mov bx,dI
		call DoMonitorOne
	pop ax
	pop bx
	call DoMonitorCX
	ret
DoMonitorBX:				;Show AX To the screen
	push bx
	push ax
		mov al,'B'
		jmp DoMonitorNX
DoMonitorCX:				;Show AX To the screen
	push cx
	push bx
	push ax
		mov al,'C'
		mov bx,cx
		call DoMonitorOneX
	pop ax	
	pop bx
	pop cx
	ret
	
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

