include \SrcALL\V1_Header.asm

	jmp Start

somedata:
	db 01h,23h,45h,67h,89h,0ABh,0CDh,0EFh
	db 12h,34h,56h,78h,9Ah,0BCh,0DEh,0F0h

somedataptr	dword somedata
;somedataptr	dword 12345678h	- Test Data for LES
	
Start:
	
	call ScreenInit
	
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump
	
	call NewLine
	
	;jmp TestImmediate		;1. Immediate Addressing (Load values from immediate numbers)
	;jmp TestRegister 		;2. Register Addressing (Value in a register)
	;jmp TestDirectMemory	;3. Direct Memory Addressing (value in specified address)
	;jmp TestRegisterIndirect ;4. Register indirect Addressing (value in address contained in a register)
	;jmp TestIndexed		;5. Based or Indexed Addressing (value in Address contained in a register plus immediate value)
	;jmp TestBasePlusIndex 	;6. Base plus indexed Addressing (Sum of two registers)
	jmp TestBasePlusIndexWithDisp ;7. Base plus index with displacement Addressing (Sum of base register, index register, and displacement)
	
	jmp $
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
TestImmediate:		;1. Immediate Addressing (Load values from immediate numbers)

;This is the mode we used in the first lesson - we're just load in fixed values specified in the ASM code
;this works the way we saw before with AX,BX,CX and DX - and their 8 bit counterparts

	call DoMonitorAXBX
	
	mov ax,1234h	;Load 1234 (in hex) into 16 bit pair AX
	
	mov bh,0FFh		;Load FF (in hex) into 8 bit BH (high part of BX)
	mov bl,0EEh		;Load EE (in hex) into 8 bit BL (low part of BX)

	call DoMonitorAXBX
	
;as well as the 'main' registers - we have 'Segment registers' - these have special purposes for addressing.... we'll learn more about them soon!
; The Segment registers CS,DS ES and SS cannot be set via immediate methods - we'll have to load another register then transfer the value.
	
	mov ax,01234h	;We can't directly load ES and other similar registers
	mov es,ax		;Set ES to AX
	
	call NewLine
	call domonitor
	
;There will be times we'll want to get the assembler to calculate a segment for us... lets get it to calculate the 'segment' of 
;our code! 
	
	mov ax, @code	;DS points to our Code segment
    mov es, ax		;set ES to AX
	
	call NewLine
	call domonitor
	
	
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

TestRegister:			;2. Register Addressing (Value in a register

;WE also looked at this before - this is just a command where both source and destinations are registers

	mov ax,01234h		;Load a test value via Immediate addressing
	call DoMonitorAXBX
	call NewLine
	
	mov bh,ah			;Set BH to the value in AH via register addressing
	call DoMonitorAXBX
	
	mov bl,bh			;Set BL to the value in BH via register addressing
	call DoMonitorAXBX

	mov ax,bx			;Set AX to the value in BX via register addressing
	call DoMonitorAXBX
	call NewLine
	
	mov ax,01234h		;Load a test value via Immediate addressing
	call DoMonitorAXBX
	
	XCHG bx,ax			;Swap BX and AX via register addressing
	call DoMonitorAXBX

	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


TestDirectMemory: 		;3. Direct Memory Addressing (value in specified address)

;We can read from an address by specifying it with square brackets [addr]
;This is where our 'Segments' come into play

;The 8086 uses a 20 bit address bus - but the registers are only 16 bit - how do we specify the remaining 4 bits?
;Well, these are taken from a 'Segment' register - the bottom 16 bits are taken from a register or fixed immediate value 
;A segment register is added to the top 16 bits of the address


;----DDDDDDDDDDDDDDDD ... D=DX
;EEEEEEEEEEEEEEEE---- ... E=ES

	call DoMonitorAXBX	


;Load from an address specified in square brackets... as we don't specifiy otherwise this will read from DS
;effectively the same as [ds:000Ch]
	
	push ds					;Back up DS
	
		mov ax, @code		;Point AX (data segment) to our code
		mov ds, ax			;Set DS (Data Segment) to AX (we can't do this directly)
	
		mov ax,[000Ch]		;Will read from DS by default... 
								;so we're reading from 000Ch in our code 
	pop ds					;Restore DS
	
	call DoMonitorAXBX	
	
;We can load a register from an address label... for example the 'SomeData' label in our code segment.
;When we want to load from a label in this way, we need to specify this with an extra specifiet:

;BYTE PTR tells the assembler we want to load an 8 bit BYTE from the label
;WORD PTR tells the assembler we want to load an 16 bit WORD from the label
	
;if we put a code segment name and colon before an address - we will override the segment
;which otherwise defaults to DS... for example, lets load from the code segment CS
	
	
	call NewLine
	
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump
	
	call NewLine
	
	mov al,BYTE PTR [cs:somedata]	;Load AL (8 bit) from label SomeData in segment CS
	mov bx,WORD PTR [cs:somedata+2]	;Load BX (16 bit) from label SomeData+2 in segment CS
	
	call DoMonitorAXBX

;We can save data to ram addresses in the same way.
	
	or bx,0F0F0h
	or al,0F0h
	
	call DoMonitorAXBX
	
	mov BYTE PTR [cs:somedata],al	;Store AL back into label SomeData in segment CS 
	mov WORD PTR [cs:somedata+2],bx	;Store BX back into label SomeData+2 in segment CS 
	
;Lets see the results 
	
	call NewLine
	
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump
	

	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
TestRegisterIndirect: ;4. Register indirect Addressing (value in address contained in a register)

;This addressing mode is where we use the value contained in a register as an address...
;now 

	call DoMonitorAXBX
;Lets Calculate the Segment of the 'SomeData' Label... we're going to use ES (the Extra Segment)
;We can also calculate the offset within that segment of the 'SomeData' Label

	mov ax,SEG somedata		;load the segment address of somedata
	mov es,ax
	
	mov bx,OFFSET somedata	;load the offset address of somedata
	
	call DoMonitorAXBX
	
;lets load some data from ES:BX (Data Segment ES - offset BX)	
;we can use special registers DI and SI (Destination Index and Source Index) in the same way.

	mov ax,[es:bx]			;Load from address in BX (can also use BX,BP,DI,SI)
	call DoMonitorAXBX
	
	mov di,OFFSET somedata+2
	mov bx,[es:di]	
	call DoMonitorAXBX
	
;In the examples above we specified the Extra Segment - if we don't it will default to DS	
	mov ax,[bx]				;Didn't specify segment - so loaded from DS
	call DoMonitorAXBX
			
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TestIndexed: ;5. Based or Indexed Addressing (value in Address contained in a register plus immediate value)
	
;We looked before at reading in from a label with a numberic offset
;BUT we can do the same with a value in a register!... we can specify a register and a immediate numeric offset
	
;Previous example	
	mov ax,WORD PTR [cs:somedata+4]	;Load from the label SomeData+4 in segment CS 
	call DoMonitorAXBX					;(Code Segment - running code)
	
	or ax,0F0F0h
	mov WORD PTR [cs:somedata+4],ax	;Store BX back into label SomeData+4 in segment CS 
	
	call DoMonitorAXBX

	
	call NewLine
	call NewLine
	
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump
	call NewLine
;Based addressing

	mov bx,OFFSET somedata	;load the offset address of somedata	
	
	mov ax,[cs:bx+1]		;Load from address in BX +n (can also use BX,BP,DI,SI)
	call DoMonitorAXBX
	
	add bx,2				;Add 2 to bx
	
	or ax,0F0F0h
	mov [es:bx],AX		;Save it back
	
	call DoMonitorAXBX
	
	call NewLine
	
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump

	call NewLine
	
;We can define a symbol with an offset position, and use the register as a pointer to a bank of settings.
;For example lets define 'SecondVariable' at position +2 , and a third called 'ThirdVariable' at position +4
;We can now Read it's value with this or write it back.

	mov bx,OFFSET somedata	;load the offset address of somedata	
	
SecondVariable equ 2
ThirdVariable equ 4
	mov ax,[es:bx+SecondVariable]	
	
	call DoMonitorAXBX

	mov [es:bx+ThirdVariable],6655h
	
	call NewLine
	
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump
	
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestBasePlusIndex: ;6. Base plus indexed Addressing
	
	
;We can use registers DI/SI as an offset with BX/BP - where the two registers are added together... 
;there's a limit to the registers we can use for this... we can use BX+DI, BX+SI, BP+DI, BP+SI

	
	mov bp,OFFSET somedata	;load the offset address of somedata
	mov ax,SEG somedata		;load the segment address of somedata
	mov es,ax
	mov di,1				;Set DI =1
	call DoMonitorAXBXBPDI
	
	
	mov ax,[es:bp+di]		;Load from address in bp +di (can also use BX+DI, BX+SI, BP+SI)
	inc di
	mov bx,[es:bp+di]		;We've increased DI - lets load again
	
	call DoMonitorAXBXBPDI
	
	inc di					;Load in another value
	mov ax,[es:bp+di]				
	inc bp					;We can also change the base pointer for the same effect
	inc bp
	mov bx,[es:bp+di]	
	
	call DoMonitorAXBXBPDI
	
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestBasePlusIndexWithDisp: ;7. Base plus index with displacement Addressing (Sum of base register, index register, and displacement)
	
;We can use a Base Register - an index register, and an immediate displacement
	
	call DoMonitorAXBX

	mov bp,OFFSET somedata	;load the offset address of somedata
	mov ax,SEG somedata		;load the segment address of somedata
	mov es,ax
	
	mov di,3				;Set Our Displacement
	
	mov ax,[es:bp+di+1]	;Load from address in bp+di+n (can also use BX+DI+n, BX+SI+n, BP+SI+n)
	mov bx,[es:bp+di+2]	
	call DoMonitorAXBXBPDI

;Depending on the syntax, you may see the displacement outside the brackets - the result is the same.
;We can also use symbols to make things clearer!

	mov ax,[es:bp+di]+1		;offset outside brackets - it has the same meaning
	mov bx,[es:bp+di]+2	
	call DoMonitorAXBXBPDI

table equ 1					;We can define a symbol as the offset and use that
table2 equ 2
		
	mov ax,table[es:bp+di]	;using a symbol - same meaning
	mov bx,table2[es:bp+di]
	call DoMonitorAXBXBPDI
	
	call NewLine
	
	mov ax,[es:bp+di-1]		;Offset can be positive or negative
	mov bx,[es:bp+di-2]	
	call DoMonitorAXBXBPDI

	call NewLine
	
;LEA - loads an Effective address - this does the address calculation and stores the resulting address in a register
;This is useful if we need to use that calculated address many times - it saves speed and bytes by only doing the calculation once.
	
	lea ax,[es:bp+di-2]		;load the address bp+di-2... into ES:BX
	;						;eg: bp=12,di=3 so 12+3-2=13
	lea bx,[es:bp+di-3]		;load the address bp+di-2... into ES:BX
	
	call DoMonitorAXBXBPDI
	
	call NewLine
	
;We have two special commands for loading 'Far pointers'... these set a full 20 bit address from a label 
;Setting both the DS/ES segment register and AX/BX/etc with a single command.
	
	lds bx, somedataptr		;Load 4 bytes from somedataptr into DS:BX
	les ax, somedataptr		;Load 4 bytes from somedataptr into ES:AX
	
	call DoMonitor
	
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call NewLine
	mov bp,somedata			;Address to show
	mov bx,8				;Bytes to show
	call MemDump
	call NewLine
	
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	
DoMonitorBX:				;Show AX To the screen
	push bx
	push ax
		mov al,'B'
		jmp DoMonitorNX
DoMonitorCX:				;Show AX To the screen
	push cx
	push ax
		mov al,'C'
		jmp DoMonitorNX
	
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

